#!/usr/bin/env python
import regex
import fileinput

sub = dict(
math_environs = '|'.join(['cases', 'align', 'vmatrix', 'bmatrix','pmatrix','matrix']),

braceargs = r'''
 \{ #open brace
 (?<braceargs> #capturing group braceargs
 (?:
  [^{}]++ #anyting but parenthesis one or more times without backtracking
  | #or
   \{(?&braceargs)\} #recursive substitute of group rec
 )*
 )
 \} #close brace
'''
)

def macromatch(macro, elt, eltargs=''):
    mysub = sub.copy()
    mysub.update(dict(macro=macro, elt=elt, eltargs=eltargs))
    return (r'\\%(macro)s %(braceargs)s'%mysub,
            r'<%(elt)s%(eltargs)s>\g<braceargs></%(elt)s>'%mysub)

regexps = [
    (r'&', r'&amp;'),
    (r'<', r'&lt;'),
    (r'``', r'&ldquo;'),
    (r"''", r'&rdquo;'),
    (r'\\item', r'<li>'),
    (r"((?:^%.*$\n)+)", r'<div class="comment">\1</div>'),
    (r'\\href %(braceargs)s \{(?<text>[^}]*)\}'%sub, r'<a href="\g<braceargs>">\g<text></a>'),
    (r'\\ref %(braceargs)s'%sub, r'<a href="#\g<braceargs>">TODO</a>'),
    (r'\\begin\{enumerate\}', '<ol>'),
    (r'\\end\{enumerate\}', '</ol>'),
    (r'\\begin\{itemize\}', '<ul>'),
    (r'\\end\{itemize\}', '</ul>'),
    (r'\\begin\{(?<env>(?!%(math_environs)s)[^}]*)\}\[(?<label>.*)\]'%sub,
     r'<div class="\g<env>" label="\g<label>">'),
    (r'\\begin\{(?<env>(?!%(math_environs)s)[^}]*)\}'%sub, r'<div class="\g<env>">'),
    (r'\\end\{((?!%(math_environs)s)[^}]*)\}'%sub, r'</div>'),
    macromatch('subsection','h2'),
    macromatch('section','h1'),
    macromatch('bmw','span',' class="bmw"'),
    macromatch('larsonfive','span',' class="larsonfive"'),
    macromatch('marginpar', 'div', ' class="marginpar"'),
    macromatch('note', 'div', ' class="note"'),
]

stdin = ''.join(fileinput.input())

for i,(p,r) in enumerate(regexps):
    #print 'regex',i
    stdin = regex.sub(p,r,stdin, flags=regex.VERBOSE|regex.MULTILINE)
print stdin

