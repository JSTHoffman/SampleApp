#Chapter 4 Exercise 1

### SHUFFLE STRING PROCEDURE ################
#Purpose: shuffles a STRING
def Shuffle(someString)

	#split, shuffle, rejoin, and return string
	someString.split('').shuffle.join

end

#local variable
@shuffledString

#get string
print("please enter string: ")

#call shuffle procedure
@shuffledString = Shuffle(gets().chop!)

#print shuffledString
puts(@shuffledString)

