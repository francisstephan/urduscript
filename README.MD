# Type on Latin keyboard, get Urdu text

At first, refer to the given tables to get the characters you want. After a time this will become automatic.

Try live at https://www.eludev.fr/urdu

# Programming language
The application is written with Elm, which allows for:
- easy and clean development
- very small application size
- easy communication with javascript
- simple, consistent and efficient tooling

# Rationale

We generally followed the same transcription as in our arabic and persian script tools, with some adaptations:

## _ prefixed characters:
We use for instance _t to get ث , _s to get ش

For the Arabic emphatics (ص ض ط ظ) we use _S, _D (referring to arabic, not to urdu phonetic value), _T and _Z.

## retroflex consonants

Urdu retroflex consonants (ٹ ڈ ڑ) are transcribed as T, D and R

## nun ghunna

To get nun ghunna  ں  (nasalization mark at end of word) type n'


## aspirated consonants

Aspirated consonants are represented as digraphs, just as in Urdu:
b'	p'	t'	T'	j'	c'	d'	D'	R'	k' g' correspond to  بھ	پھ	تھ	ٹھ	جھ	چھ	دھ	ڈھ	ڑھ	کھ  گھ 

To get an accurate representation (with do chashmi he) you need to use a Nastaliq font :

## nastaliq font:

If you try the program live at [https://eludev.fr/urdu/](https://eludev.fr/urdu/), you will see the aspirated digraphs such as k' کھ with a much nicer representation (if you try kh instead of k' you will get a totally different digraph!).

This only appears if you use a nastaliq font.

For an introduction to Nastaliq, see [https://en.wikipedia.org/wiki/Nastaliq#Notes](https://en.wikipedia.org/wiki/Nastaliq#Notes)

We use the Google Noto Nastaliq Urdu font.

For an introduction to Google Noto fonts, see [https://en.wikipedia.org/wiki/Noto_fonts#External_links](https://en.wikipedia.org/wiki/Noto_fonts#External_links)

To learn how to use Noto fonts, read [https://design.google/library/hot-type-always-fresh](https://design.google/library/hot-type-always-fresh) and [https://developers.google.com/fonts/docs/getting_started](https://developers.google.com/fonts/docs/getting_started)

For our urdu script program, this very simply translates to:
- 3 lines in index.html (just after the <head> tag):
```
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Nastaliq+Urdu:wght@400..700&display=swap" rel="stylesheet">
```

- and the following in the style.css stylesheet:
```
#convert{
  font-family: "Noto Nastaliq Urdu", serif;
  font-optical-sizing: auto;
  font-style: normal;
  font-weight: 400; /* weight should be in the 400 -700 range */
  font-size: 1.5em;
}
```
with `serif` beeing the fallback font in the font-family specifiation.

On my mac, Noto Nastaliq Urdu is also available in MS Word fonts.

# Unrecognized characters

Any character not recognized is rendered unmodified.


# Licence

MIT
