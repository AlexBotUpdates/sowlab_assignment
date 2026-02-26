enum AppEnvironment { dev, staging, prod }

class EnvConfig {
  final String baseUrl;
  final AppEnvironment environment;

  EnvConfig({
    required this.baseUrl,
    required this.environment,
  });

  static EnvConfig get dev => EnvConfig(
        baseUrl: "https://sowlab.com/assignment/",
        environment: AppEnvironment.dev,
      );

  static EnvConfig get prod => EnvConfig(
        baseUrl: "https://sowlab.com/assignment/", // Update with prod URL
        environment: AppEnvironment.prod,
      );
}
