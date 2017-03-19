iex(82)> x = 1
1
iex(83)> x = 2
2
iex(84)> 2 = x
2
iex(85)> 1 = x
** (MatchError) no match of right hand side value: 2

# deep matching
iex(87)> {a, b, [c1,c2,c3]} = {:hello, "world", [42,43,44]}
{:hello, "world", '*+,'}
iex(88)> c2
43
iex(89)> b
"world"

# head/tail matching
iex(91)> [hh | tt] = Enum.to_list(1..10)
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
iex(92)> hh
1
iex(93)> tt
[2, 3, 4, 5, 6, 7, 8, 9, 10]


# Use the pin operator ^ when you want to pattern match against an existing variable’s value
# rather than rebinding the variable:
iex(94)> x = 1
1
iex(95)> x = 2
2

iex(96)> x = 1
1
iex(97)> ^x = 2
** (MatchError) no match of right hand side value: 2


# In some cases, you don’t care about a particular value in a pattern.
# It is a common practice to bind those values to the underscore, _.
iex(98)> [hh | _] = [2,4,8,16]
[2, 4, 8, 16]
iex(99)> hh
2
iex(100)> _
** (CompileError) iex:100: unbound variable _
