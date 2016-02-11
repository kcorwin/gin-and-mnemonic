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
	"9" => ["p"],
	"_" => [" "]
}


def toArray(word)
	return word.scan(/./)
end

def asLetters(n)
	return ($numToLett[n] or [n])
end

def mnemonic(numStr)
	exploded = numStr.map { |n| asLetters(n) }
	return exploded.reduce { |memo,obj| memo.map { |n| obj.map { |nn| "#{n}#{nn}" } }.flatten }
end

def invert(letter)
	return $numToLett.each_pair.select { |k,v| v.include? letter.downcase }.flatten[0]
end

def revertWord(word)
	return word.split("").map { |c| invert(c) }
end

def deleteAnyFirst(arr, objs)
	return objs.map { |n| deleteFirst(arr, n) }.flatten.compact
end

def deleteFirst(arr, obj)
	# http://stackoverflow.com/a/4595353/2235819
	return arr.delete_at(arr.index(obj) || arr.length)
end

def diff(first, second)
	result = Array.new(first)
	second.each { |c| deleteFirst(result, c) }
	return result
end

def main()
	asLetters = mnemonic(ARGV)

	withoutUnderscore = ARGV.reject { |c| c == '_' }

	permutations =  asLetters.map { |word| toArray(word).permutation.to_a.map { |w| w.join("") } }.flatten

	permutations.each { |s| s.strip! }

	#print "Possibilities: #{permutations.join(", ")}\n"
	print "Possibilities for #{asLetters.map(&:strip).join('/')}: #{permutations.length}\n"

	regex = permutations.map { |word| word.split(" ") } \
		.flatten \
		.uniq \
		.select { |word| word.length > 2 }
		.join("|")

	results = open($dictfile) { |f| f.grep(/^(#{regex})$/i) } \
		.each { |res| res.strip! }
	# ^ can maybe get rid of ^ and/or $ to get more possibilities for tough words.

	if results.empty?
		results = open($dictfile) { |f| f.grep(/^(#{regex})/i) } \
			.each { |res| res.strip! }
			.select { |word| word.length <= withoutUnderscore.length + 2 }
			.sort { |b, a| a.length <=> b.length }
		if withoutUnderscore.length < ARGV.length
			results = results.map { |word| word.insert(withoutUnderscore.length, "-") }
		end

		print results.join(", ")
	else
		print results \
			.sort { |a, b| b.length <=> a.length } \
			.map { |word|
					 reverted = revertWord(word)
					 diff = diff(withoutUnderscore, revertWord(word)).join('')
					 "#{word} -- #{reverted.join("")}#{diff.empty? ? "" : " + #{diff}"}"
				 } \
			.join("\n")
	end

	print "\n"
end


main()
