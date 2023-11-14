# Table of Contents
1. [Loops and Conditions](#loops-and-conditions)
2. [Structs](#structs)
3. [Data Type](#data-types)
4. [Functions](#functions)
5. [Interface](#interface)

## Loops and Conditions

    for  i := 1 ; i < N ; i++ {           for var1 < var2 {
        Statement                             var1--   // or var2++
    }                                     }

    for _ , v  :=  range {   // range can be array, slice or map
        Statement  
    }


    if cond {
        Statement
    }

    switch  {                           switch  var {
    case var == smt :                   case smt : 
        Statement                           Statement
    }                                   }

        

## Operations

    var = append(var, Val1, Val2)
    var = append(var, slice...)
    defer fmt.Println("fds") //executa esse comando por último


## Structs

### General declaration
    type NAME struct { 
        atr1 type
        atr2 type
    }

### Assignment it to a variable
    name1  :=  name {
        atr1: value,
        atr2: value,
    }


## Data Types
T will be the values types (int, slice, struct)

    array  :=  [SIZEnumb] type { val1, val2, values }
    slice  :=  [ ] type{ val1, val2, values }
    make0  :=  make( [ ] type, len, cap) //works for slice and array
    make1  :=  make( map[type]T )        //works for map
    matrix  :=  [ ][ ] type {
            [ ]type {
        },
            [ ]type {
        },
    }
    mepe  :=  map [type]T{          
       "key1": values,
    }


## Functions

### Default
    func (receiver) identifier (parameters) (returns) { code }

### Function without parameters 
it will return an element of type type

    func NAME() type{code}

it will return two elements of type type1 and type2

    func NAME() (type1, type2) { code }

### Function with parameters
variadic parameters of type type and will return nothing

    func NAME(var ...type) { code }

2 normal parameters

    func NAME(var type, var2 type2) type { code }

### Anonymous function
works inside main (runtime)

    func(par) { code } ()

assignment to a variable

    var := func(par) { code }; var()

### Function that returns another function
the return must contain the function

    func NAME() func() { code }

### Function that receives as parameter another function
    func NAME(f func()) { code }

## Interface
### Default
    type NAME interface { code }
### Every struct that has the area method belongs to the figure interface
    type figure interface { area() }
