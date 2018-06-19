/*
  list is immutable
  Array is mutable


  VARIANCE
      Functions are contravariant in argument types
      covaraiant in result type

      trait Function1[-T, +U] {
          def apply (x: T): U
      }


  Say
      C[T] is a parameterized type   and
      A <: B                                // A subtype of B

      C[A] <: C[B]                    C is covariant

      C[A] >: C[B]                    C is contravariant

      C[A] not sub or super C[B]      C is non-variant

  Define a class

      class C[+A]                     C is covariant
      class C[-A]                     C is contravariant
      class C[A]                      C is non-variant

  Typing Rules for Functions

      How to subtype btw functions
          arguments
          return types

      For a given myFunction(Argument) : ReturnType

        -- ----------------------------
        This is true
          myFunction(ArgumentType1) : ReturnType1
            is a subtype <: of
          myFunction(ArgumentType2) : ReturnType2

          written like this
              myF(ArgumentType2) => ReturnType1   <:    myF(Argument2) => ReturnType2

              or

              ArgumentType2 => ReturnType1   <:    Argument2 => ReturnType2
        -- ----------------------------
        If
            ArgumentType2 <: Argument1  &&  ReturnType1 <: ReturnType2


        NOTE: Return types go in right-hand direction
              Argument types go in left-hand direction


              ArgumentType2 <:  ArgumentType2
              ReturnType1 <: ReturnType2



 */