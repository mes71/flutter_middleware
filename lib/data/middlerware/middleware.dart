import 'package:flutter/foundation.dart';

abstract class Middleware {
  Middleware? _next;

  //build chain of middleware objects.
  static Middleware link(Middleware first, List<Middleware> chain) {
    Middleware head = first;
    for (Middleware nextInChain in chain) {
      head._next = nextInChain;
      head = nextInChain;
    }
    return first;
  }

  //Subclass will implement this method with concrete checks.
  T check<T>(String email, String password);

  //Runs check on the next object in chain or ends traversing if we 're in
  //last object in chain
  @protected
  T? checkNext<T>(String email, String password) {
    return _next?.check(email, password);
  }
}
