/**
 * @embroider/macros needs to ship ESM
 * for their runtime fallback
 */
export function isDevelopingApp() {
  return true;
}

export function dependencySatisfies() {
  return true;
}

export function macroCondition() {
  return true;
}
