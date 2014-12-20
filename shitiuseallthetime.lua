rb, rbs, rw, rws, rd, rds = memory.readbyte, memory.readbytesigned, memory.readword, memory.readwordsigned, memory.readdword, memory.readdwordsigned
wb, ww, wd = memory.writebyte, memory.writeword, memory.writedword

function hexval(val)
	val = string.format("%X",val)
	return val
end

--Shapes
function drawaxis(x,y,axis,color)
gui.line(x+axis,y,x-axis,y,color)
gui.line(x,y+axis,x,y-axis,color)
end

function boxrad(x,y,w,h,color)

rgt = x + w
lft = x - w
top = y + h
btm = y - h

gui.box(lft,top,rgt,btm,color)
end

function boxcorner(left,top,w,h,color)
rgt = left + w
btm = top + h

gui.box(left,top,rgt,btm,color)
end

