#! /usr/bin/ruby

$dictfile = "/usr/share/dict/words"

$numToLett = {
	"0" => ["o"],
	"0.5" => ["h"],
	"1" => ["l", "i"],
	"1.5" => ["f"],
	"2" => ["z", "n"],
	"3" => ["m", "w", "e"],
	"4" => ["a"],
	"5" => ["s"],
	"6" => ["g"],
	"7" => ["t"],
	"8" => ["b"],
	"9" => ["p"]
}


def toArray(word)
	return word.scan(/./)
end

def mnemonic(numStr)
	exploded = numStr.map { |n| $numToLett[n] }
	return exploded.reduce { |memo,obj| memo.map { |n| obj.map { |nn| "#{n}#{nn}" } }.flatten }
end

def dict(word)
	return open($dictfile) { |f| f.grep(/^#{word}$/) }
end

def main()
	asLetters = mnemonic(ARGV)

	permutations =  asLetters.map { |word| toArray(word).permutation.to_a.map { |w| w.join("") } }.flatten

	print "Possibilities: #{permutations.join(", ")}\n"

	regex = permutations.join("|")

	results = open($dictfile) { |f| f.grep(/^(#{regex})$/i) }

	print results.join("")
end


main()
