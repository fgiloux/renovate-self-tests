module.exports = {
  repositories: ["fgiloux/renovate-self-tests"],
  username: "fgiloux-renovate[bot]",
  secrets: {
    RH_REGISTRY_USERNAME: "{{ process.env.RH_REGISTRY_USERNAME }}",
    RH_REGISTRY_PASSWORD: "{{ process.env.RH_REGISTRY_PASSWORD }}",
  },
  hostRules: [
    {
      matchHost: "https://registry.redhat.io",
      hostType: "docker",
      username: "{{ process.env.RH_REGISTRY_USERNAME }}",
      password: "{{ process.env.RH_REGISTRY_PASSWORD }}",
    },
  ],
};
