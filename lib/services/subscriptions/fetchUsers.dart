final String fetchUsers = """
  subscription fetchOnlineUsers {
    online_users {
      user{
        name
      }
    }
  }""";
