const
    breakCompilation = false
    evalFizzBuzz = false

#cons is for compile-time constants
const npic = "Compile-time Metaprogramming in Nim!" # this is now present in the compile_time.nim binary
echo npic




when evalFizzBuzz:
    # only imported and therefore compiled into binary when needed
    import std/sequtils
    import std/sugar

    # .compileTime. Pragma ensures this is only callable during compile time
    proc fizzbuzz(number: int): string {.compileTime.} =
        if number mod 3 == 0:
            result = "Fizz"
        if number mod 5 == 0:
            result &= "Buzz"
        if result == "":
            result = $number

    const numbers = toSeq(1..100).map(x => fizzbuzz(x)) # $ allows us to transform the numbers to string
    for num in numbers:
        echo num


# when is compile time if
when breakCompilation:
    const input = readline(stdin)


method angry_echo(e : string): void =
    echo e & "!!!!"






