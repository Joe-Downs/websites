html :
	pandoc index.org -o index.html -c css/retro.css --template=template.html --metadata title="Welcome!"
	pandoc about.org -o about.html -c css/retro.css --template=template.html --metadata title="About Me"
	pandoc tao.org -o tao.html -c css/retro.css --template=template.html --metadata title="The Tao of Programming"

# Pandoc escapes single and double quotes and asterisks when converting to
# Markdown... which translates to literal backslashes in gemtext, but doesn't
# with the older GitHub-flavored Markdown output mode (markdown_github rather
# than gfm). However, it does escape angled brackets, so we need to replace
# those with their literal counterparts.
md_sed = sed 's/\\</</' | sed 's/\\>/>/' | sed 's/\\\*/\*/'
md :
	pandoc index.org -t markdown_github | $(md_sed) > index.md
	pandoc about.org -t markdown_github | $(md_sed) > about.md
	pandoc tao.org -t markdown_github | $(md_sed) > tao.md

gemtext :
	gemgen index.md
	gemgen about.md
	gemgen tao.md

