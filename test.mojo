

# Mojo is a programming language that is as easy to use as Python but with the performance of C++ and Rust.
# More importantly, Mojo allows you to leverage the entire Python ecosystem so you can continue to use tools you are familiar with. Mojo is designed to become a superset of Python over time by preserving Python’s dynamic features while adding new primitives for systems programming. 
# based on MLIR and LLVM, which offer a cutting-edge compiler and code generation system used in many programming languages. This lets us have better control over data organization, direct access to data fields, and other ways to improve performance.

# let and var
# scoped runtime value declarations: let is immutable and var is mutable - use lexical scoping and support name shadowing
# optional use when in a def dunction but required for all variables in a fn function. For top-levels variables (the ones outside a function or struct) are also optional the use.
# eg: let|var variable_name(: DataType (= Value))

# struct types
An important feature of modern systems programming languages is the ability to build high-level and safe abstractions on top of these complex, low-level operations without any performance loss.
similar to a Python class: they both support methods, fields, operator overloading, decorators for metaprogramming, etc. Their differences are as follows:
Python classes are dynamic: they allow for dynamic dispatch, monkey-patching (or “swizzling”), and dynamically binding instance properties at runtime.
Mojo structs are static: they are bound at compile-time (you cannot add methods at runtime). Structs allow you to trade flexibility for performance while being safe and easy to use.
Syntactically, Python class and Mojo structs has the difference that all instance properties in a sctruct must be explicitly declared wiht a var or let
The static spect of the struct helps the code to run fast - it know what to spacted.

struct MyPair:
   var first: Int
   var second: Int

   # We use 'fn' instead of 'def' here - we'll explain that soon
   fn __init__(inout self, first: Int, second: Int):
      self.first = first
      self.second = second

   fn __lt__(self, rhs: MyPair) -> Bool:
      return self.first < rhs.first or
            (self.first == rhs.first and
            self.second < rhs.second)

# Functions
def is defined by necessity to be very dynamic, flexile, arguments are mutable, local variable are implicity declared, which is great for high level programming and scripting
fn is like a strict mode for def, being better for systems programming; is more limited and controlled on the inside of its body (alternatively: pedantic and strict).
Values passed into a Python def function use reference semantics - the objets are mutable, the func can modify it and those change are visible outside the function
Values passed into a Mojo def function use value semantics by default - receives a copy of all arguments, can modify inside the function, but the changes are not visible outside it
Values passed into a Mojo fn function are immutable references by default - func can read the original object, but cannot modify at all
Borrowed objects is an immutable reference to an object that a func receives, instead of a copy. So, the func has full read-and-execute access but it cannot modify it (is the default, but can be explicitly defined) - the caller has exclusive ownership of the object
On the other hand, to the argument be mutable, declare it with the inout keyword, so, it means any changes made to the argument inside the functions are visile outside
The owned/^ is used for functions that want to take exclusive ownership over a value, by ending the lifetime of a value binding and transfers the value ownership to it - func has unique access to the value
Argument default type is a Object
def example((borrowed) a: Int, b: Int, c(: Object)):
   # b and c use value semantics so they're mutable in the function
   ...

# Overloaded functions and methods



# Importing python modules - currently, need to import the whole module
from python import Python
let np = Python.import_module("numpy") # use any module name
array = np.array([1, 2, 3])

