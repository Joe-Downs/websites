import drawSvg as draw

d = draw.Drawing(256, 256, origin='center', displayInline = False)

d.append(draw.Circle(0,0,128, fill='#00FF00', stroke_width=1, stroke='#00FF00'))

d.saveSvg('favicon.svg')
