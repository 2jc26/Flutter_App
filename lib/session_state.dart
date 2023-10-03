abstract class SessionState{}

class UnkownSessionState extends SessionState{}

class Authenticated extends SessionState{
  final String userid; // O coloar el id o el usario para que se pase.

  Authenticated({required this.userid});
}

class Unauthenticated extends SessionState{}