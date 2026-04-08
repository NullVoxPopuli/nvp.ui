// eslint-disable-next-line @typescript-eslint/ban-ts-comment
// @ts-nocheck
import "./animated-gradient.css";

import { modifier } from "ember-modifier";

import type { TOC } from "@ember/component/template-only";

export type GradientPreset = "lava" | "prism" | "plasma" | "pulse" | "vortex" | "mist";

const PRESETS: Record<
  GradientPreset,
  { colors: [number, number, number][]; speed: number; swirl: number }
> = {
  lava: {
    colors: [
      [1, 0.2, 0],
      [1, 0.5, 0],
      [0.8, 0, 0],
    ],
    speed: 0.5,
    swirl: 2.0,
  },
  prism: {
    colors: [
      [1, 0, 0.5],
      [0, 0.5, 1],
      [0.5, 1, 0],
    ],
    speed: 1.0,
    swirl: 1.5,
  },
  plasma: {
    colors: [
      [0.5, 0, 1],
      [0, 1, 1],
      [1, 0, 0.5],
    ],
    speed: 1.2,
    swirl: 3.0,
  },
  pulse: {
    colors: [
      [0, 0.8, 1],
      [0, 0.4, 0.8],
      [0.2, 0, 0.6],
    ],
    speed: 0.8,
    swirl: 0.5,
  },
  vortex: {
    colors: [
      [0.1, 0, 0.3],
      [0.5, 0, 0.8],
      [0, 0.3, 1],
    ],
    speed: 0.6,
    swirl: 4.0,
  },
  mist: {
    colors: [
      [0.8, 0.85, 0.9],
      [0.6, 0.7, 0.8],
      [0.9, 0.9, 0.95],
    ],
    speed: 0.3,
    swirl: 0.8,
  },
};

const VERTEX_SHADER = `
  attribute vec2 a_position;
  void main() {
    gl_Position = vec4(a_position, 0.0, 1.0);
  }
`;

const FRAGMENT_SHADER = `
  precision mediump float;
  uniform float u_time;
  uniform vec2 u_resolution;
  uniform vec3 u_color1;
  uniform vec3 u_color2;
  uniform vec3 u_color3;
  uniform float u_speed;
  uniform float u_swirl;

  // Simplex-like noise
  vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
  vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
  vec3 permute(vec3 x) { return mod289(((x * 34.0) + 1.0) * x); }

  float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                        -0.577350269189626, 0.024390243902439);
    vec2 i = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;
    i = mod289(i);
    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0)) + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x12.xy, x12.xy), dot(x12.zw, x12.zw)), 0.0);
    m = m * m;
    m = m * m;
    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
  }

  void main() {
    vec2 uv = gl_FragCoord.xy / u_resolution;
    float t = u_time * u_speed * 0.1;

    // Swirl distortion
    float angle = snoise(uv * u_swirl + t) * 3.14159;
    vec2 distorted = uv + vec2(cos(angle), sin(angle)) * 0.1;

    // Layer noise at different scales
    float n1 = snoise(distorted * 2.0 + t * 0.7) * 0.5 + 0.5;
    float n2 = snoise(distorted * 3.0 - t * 0.5) * 0.5 + 0.5;

    // Blend colors
    vec3 color = mix(u_color1, u_color2, n1);
    color = mix(color, u_color3, n2 * 0.5);

    // Add subtle brightness variation
    color += snoise(distorted * 5.0 + t) * 0.05;

    gl_FragColor = vec4(color, 1.0);
  }
`;

function hexToRgb(hex: string): [number, number, number] {
  const h = hex.replace("#", "");
  const r = parseInt(h.substring(0, 2), 16) / 255;
  const g = parseInt(h.substring(2, 4), 16) / 255;
  const b = parseInt(h.substring(4, 6), 16) / 255;

  return [r, g, b];
}

function createShader(gl: WebGLRenderingContext, type: number, source: string): WebGLShader | null {
  const shader = gl.createShader(type);

  if (!shader) return null;
  gl.shaderSource(shader, source);
  gl.compileShader(shader);

  if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
    gl.deleteShader(shader);

    return null;
  }

  return shader;
}

function createProgram(
  gl: WebGLRenderingContext,
  vs: WebGLShader,
  fs: WebGLShader,
): WebGLProgram | null {
  const program = gl.createProgram();

  if (!program) return null;
  gl.attachShader(program, vs);
  gl.attachShader(program, fs);
  gl.linkProgram(program);

  if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
    gl.deleteProgram(program);

    return null;
  }

  return program;
}

const webglGradient = modifier(
  (
    canvas: HTMLCanvasElement,
    _pos: unknown[],
    {
      preset,
      colors,
      speed,
      swirl,
    }: {
      preset?: GradientPreset;
      colors?: string[];
      speed?: number;
      swirl?: number;
    },
  ) => {
    const gl = canvas.getContext("webgl");

    if (!gl) return;

    const vs = createShader(gl, gl.VERTEX_SHADER, VERTEX_SHADER);
    const fs = createShader(gl, gl.FRAGMENT_SHADER, FRAGMENT_SHADER);

    if (!vs || !fs) return;

    const program = createProgram(gl, vs, fs);

    if (!program) return;

    // Full-screen quad
    const buffer = gl.createBuffer();

    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      new Float32Array([-1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, 1]),
      gl.STATIC_DRAW,
    );

    const posAttr = gl.getAttribLocation(program, "a_position");

    gl.enableVertexAttribArray(posAttr);
    gl.vertexAttribPointer(posAttr, 2, gl.FLOAT, false, 0, 0);

    // Resolve config
    const config = preset ? PRESETS[preset] : PRESETS.prism;
    const c = colors && colors.length >= 3 ? colors.map(hexToRgb) : config.colors;
    const spd = speed ?? config.speed;
    const swl = swirl ?? config.swirl;

    // Uniforms
    gl.useProgram(program);

    const uTime = gl.getUniformLocation(program, "u_time");
    const uRes = gl.getUniformLocation(program, "u_resolution");
    const uColor1 = gl.getUniformLocation(program, "u_color1");
    const uColor2 = gl.getUniformLocation(program, "u_color2");
    const uColor3 = gl.getUniformLocation(program, "u_color3");
    const uSpeed = gl.getUniformLocation(program, "u_speed");
    const uSwirl = gl.getUniformLocation(program, "u_swirl");

    gl.uniform3fv(uColor1, c[0] as number[]);
    gl.uniform3fv(uColor2, c[1] as number[]);
    gl.uniform3fv(uColor3, c[2] as number[]);
    gl.uniform1f(uSpeed, spd);
    gl.uniform1f(uSwirl, swl);

    // Resize handling
    const observer = new ResizeObserver(() => {
      const rect = canvas.getBoundingClientRect();

      canvas.width = rect.width * devicePixelRatio;
      canvas.height = rect.height * devicePixelRatio;
      gl.viewport(0, 0, canvas.width, canvas.height);
    });

    observer.observe(canvas.parentElement ?? canvas);

    // Initial size
    const rect = canvas.getBoundingClientRect();

    canvas.width = rect.width * devicePixelRatio;
    canvas.height = rect.height * devicePixelRatio;
    gl.viewport(0, 0, canvas.width, canvas.height);

    // Animation loop
    let animId = 0;
    const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");

    function render(time: number) {
      gl.uniform1f(uTime, time * 0.001);
      gl.uniform2f(uRes, canvas.width, canvas.height);
      gl.drawArrays(gl.TRIANGLES, 0, 6);

      if (!reducedMotion.matches) {
        animId = requestAnimationFrame(render);
      }
    }

    animId = requestAnimationFrame(render);

    return () => {
      cancelAnimationFrame(animId);
      observer.disconnect();
      gl.deleteProgram(program);
      gl.deleteShader(vs);
      gl.deleteShader(fs);
      gl.deleteBuffer(buffer);
    };
  },
);

export interface Signature {
  Element: HTMLDivElement;
  Args: {
    /**
     * Preset gradient configuration
     */
    preset?: GradientPreset;
    /**
     * Override colors as hex strings (requires 3 colors)
     */
    colors?: string[];
    /**
     * Speed multiplier (default varies by preset)
     */
    speed?: number;
    /**
     * Swirl distortion intensity (default varies by preset)
     */
    swirl?: number;
  };
  Blocks: {
    default: [];
  };
}

export const AnimatedGradient: TOC<Signature> = <template>
  <div class="nvp__animated-gradient" ...attributes>
    <canvas
      class="nvp__animated-gradient__canvas"
      {{webglGradient preset=@preset colors=@colors speed=@speed swirl=@swirl}}
    ></canvas>
    {{#if (has-block)}}
      <div class="nvp__animated-gradient__content">
        {{yield}}
      </div>
    {{/if}}
  </div>
</template>;
