#use cases for Nim's templates



# easy one
template `!=` (a, b: untyped): bool = 
  not (a == b)

#before compiliation
echo "1 != 2 is " & $(1 != 2)

#after compiliation/ template expansion
echo "1 != 2 is " & $(not(1==2))



# rewriting the AST
template genType(name, fieldname: untyped, fieldtype: typedesc) =
  type
    name = object
      fieldname: fieldtype

genType(GeneratedInt, val, int)
genType(GeneratedString, val, string)

var genInt = GeneratedInt(val : 5)
var genString = GeneratedString(val: "hello")
echo(genInt.val) #prints 5
echo(genString.val) #prints "hello"





# Lazy eval
const
  debug = true

proc log(msg: string) {.inline.} =
  if debug: echo msg

# & and $ are performed, even if debug = false
var y = 4
log("y has the value: " & $y)


template log_template(msg: string) =
  if debug: echo msg

# no longer called if debug = true as log_template is just empty
log_template("y has the value: " & $y)