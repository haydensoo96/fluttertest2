final String tokenAuth = """
  mutation TokenAuth(\$username: String!, \$password: String!) {
    tokenAuth(username:\$username, password: \$password) {
      token
    }
  }
""";

