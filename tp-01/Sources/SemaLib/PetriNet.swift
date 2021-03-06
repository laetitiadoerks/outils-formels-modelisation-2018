/// A natural number.
public typealias Nat = UInt
/// A marking.
public typealias Marking = (Place) -> Nat

/// A Petri net structure.
public struct PetriNet {

  public init(
    places: Set<Place>,
    transitions: Set<Transition>,
    pre: @escaping (Place, Transition) -> Nat,
    post: @escaping (Place, Transition) -> Nat)
  {
    self.places = places
    self.transitions = transitions
    self.pre = pre
    self.post = post
  }

  /// A finite set of places.
  public let places: Set<Place>
  /// A finite set of transitions.
  public let transitions: Set<Transition>
  /// A function that describes the preconditions of the Petri net.
  public let pre: (Place, Transition) -> Nat
  /// A function that describes the postconditions of the Petri net.
  public let post: (Place, Transition) -> Nat

  /// A method that returns whether a transition is fireable from a given marking.
  public func isFireable(_ transition: Transition, from marking: Marking) -> Bool {
    // Write your code here.
    Swift.print(transition)
    for place in places {
        //for t in transitions {
        //Swift.print(place)
        //Swift.print(t)
        //Swift.print("jetons dans \(place):")
        //Swift.print(marking(place))
        //Swift.print("nombre dans arc \(transition):")
        //Swift.print(pre(place, transition))

        if marking(place) < pre(place, transition){
            // Swift.print(place)
            // Swift.print("jetons dans \(place):")
            // Swift.print(marking(place))
            //Swift.print("nombre dans arc \(transition):")
            //Swift.print(pre(place, transition))
            Swift.print("false")
            return false
            }
    }
    return true
  }

  /// A method that fires a transition from a given marking.
  ///
  /// If the transition isn't fireable from the given marking, the method returns a `nil` value.
  /// otherwise it returns the new marking.
  public func fire(_ transition: Transition, from marking: @escaping Marking) -> Marking? {
    // Write your code here.
    //var fireable = self.isFireable(Transition(transition.name), from: marking)
    //Swift.print(fireable)
    //Swift.print(marking)
    // for place in places{
    //     Swift.print(place)
    //     Swift.print("jetons dans \(place)")
    //     Swift.print(marking(place))
    //     var mark = marking(place)
    //     Swift.print("arc \(transition)")
    //     Swift.print("nb dans arc pre ")
    //     Swift.print(pre(place, transition))
    //     Swift.print("nb dans arc post")
    //     Swift.print(post(place, transition))
    //     var fireable = self.isFireable(Transition(transition.name), from: marking)
    //     Swift.print(fireable)
    //     if fireable == true {
    //         Swift.print(marking(place)+post(place, transition))
    //         Swift.print(marking(place)-pre(place, transition))
    //     }
    // }
    if(self.isFireable(transition, from: marking)){
        //Swift.print("lalal")
        //Swift.print(self.isFireable(transition, from: marking))
      return {(place) -> Nat in
        return marking(place) - self.pre(place,transition) + self.post(place, transition)

      }
    }

    return nil
  }

  /// A helper function to print markings.
  public func print(marking: Marking) {
    for place in places.sorted() {
      Swift.print("\(place.name) → \(marking(place))")
    }
  }

}

/// A place.
public struct Place: Comparable, Hashable {

  public init(_ name: String) {
    self.name = name
  }

  public let name: String

  public static func < (lhs: Place, rhs: Place) -> Bool {
    return lhs.name < rhs.name
  }

}

/// A transition.
public struct Transition: Comparable, Hashable {

  public init(_ name: String) {
    self.name = name
  }

  public let name: String

  public static func < (lhs: Transition, rhs: Transition) -> Bool {
    return lhs.name < rhs.name
  }

}
