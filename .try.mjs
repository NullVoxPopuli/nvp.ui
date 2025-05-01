export default scenarios();

function scenarios() {
  return {
    scenarios: [
      emberSource("4.12.0"),
      emberSource("5.12.0"),
      emberSource("latest"),
      emberSource("beta"),
      emberSource("alpha"),
    ],
  };
}

function emberSource(emberVersion) {
  let v = emberVersion.includes(".") ? `^${emberVersion}` : emberVersion;

  return {
    name: `ember-${emberVersion}`,
    npm: {
      devDependencies: {
        "ember-source": v,
      },
    },
  };
}
