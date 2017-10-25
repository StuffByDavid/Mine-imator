/// vertex_add(x, y, z, nx, ny, nz, tx, ty, [color])
/// vertex_add(pos, normal, texcoord, [color])
/// @arg pos
/// @arg normal
/// @arg texcoord
/// @arg [color]

var zz;

if (argument_count < 8)
{
	var pos, normal, texcoord, color;
	pos = argument[0]
	normal = argument[1]
	texcoord = argument[2]
	
	if (argument_count > 3) 
		color = argument[3]
	else
		color = -1
		
	vertex_position_3d(vbuffer_current, pos[@ X], pos[@ Y], pos[@ Z])
	vertex_normal(vbuffer_current, normal[@ X], normal[@ Y], normal[@ Z])
	
	if (is_array(color))
		vertex_color(vbuffer_current, color[0], color[1])
	else
		vertex_color(vbuffer_current, color, 1)
	
	vertex_texcoord(vbuffer_current, texcoord[@ X], texcoord[@ Y])
	
	zz = pos[@ Z]
}
else
{
	vertex_position_3d(vbuffer_current, argument[0], argument[1], argument[2])
	vertex_normal(vbuffer_current, argument[3], argument[4], argument[5])
	if (argument_count > 8)
		vertex_color(vbuffer_current, argument[8], 1)
	else
		vertex_color(vbuffer_current, -1, 1)
	vertex_texcoord(vbuffer_current, argument[6], argument[7])
	
	zz = argument[2]
}

var wavexy, wavez;
wavexy = 0
wavez = 0
	
// Wave
if (vertex_wave != e_vertex_wave.NONE)
{
	// Vertex Z must be within zmin and zmax (if set)
	if ((vertex_wave_zmin = null || zz > vertex_wave_zmin) &&
		(vertex_wave_zmax = null || zz < vertex_wave_zmax))
	{
		if (vertex_wave = e_vertex_wave.ALL)
		{
			wavexy = 1
			wavez = 1
		}
		else if (vertex_wave = e_vertex_wave.Z_ONLY)
			wavez = 1
	}
}

// Custom
vertex_float3(vbuffer_current, wavexy, wavez, vertex_brightness)