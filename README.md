This is a mnemonic generator to help me memorize any number of digits, where the order is unimportant. Mainly for cocktail recipes.

For example, a Brooklyn cocktail is:

* 2 oz rye whiskey (or 8 x ¼ oz measures)
* ¾ oz dry vermouth (or 3 x ¼ oz measures)
* ¼ oz Amer Picon
* ¼ oz maraschino liquer

So, the ingredients I find easy to remember. The measurements, not so much: 2-¾-¼-¼ isn't exactly catchy. I simplify it in my head as 8-3-1-1, but still. However, we can convert the numbers to letters that vaguely resemble the form of the characters: 8 -> B, 3 -> E, 1 -> L, 1-> L. So, a Brooklyn can be remembered as "BELL".

Usage:

    $ gin-and-mnemonic 8 3 1 1
    Possibilities for bmll/bmli/bmil/bmii/bwll/bwli/bwil/bwii/bell/beli/beil/beii: 288
    bell -- 8311
    bile -- 8113
    limb -- 1138

You can also mix in letters. I like "T" to remember teaspoon, or "O" for a dash of Angostura. For example: a Greenpoint is 2 ounces rye, 1 ounce sweet vermouth, 1 teaspoon yellow chartreuse, a dash or two of Angostura:

    $ gin-and-mnemonic 8 4 t o
    Possibilities for bato: 24
    boat -- 8047 + to
    bota -- 8074 + to
    Toba -- 7084 + to

Finally, when you don't have such clean matches, spaces can be your friend. Add an underscore for each space you want to allow.

This is very much incomplete. It's hard-coded to use the dictionary at "/usr/share/dict/words", and uses a fairly brute-force approach at finding words. Meaning, the more characters in a mnemonic, the slower this is.
