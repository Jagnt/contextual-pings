--[[---------------------------------------------------------
    Key Binding 
    https://github.com/MysteryPancake/GMod-Binding
-----------------------------------------------------------]]

bind = {}

local Bindings = {}

--[[---------------------------------------------------------
    GetTable()
    Returns a table of all the bindings.
-----------------------------------------------------------]]
function bind.GetTable() return Bindings end

--[[---------------------------------------------------------
    Add( number button, any identifier, function func )
    Add a binding to run when the button is pressed.
-----------------------------------------------------------]]
function bind.Add( btn, name, func )

	if not isfunction( func ) then return end
	if not isnumber( btn ) then return end

	if Bindings[ btn ] == nil then
		Bindings[ btn ] = {}
	end

	Bindings[ btn ][ name ] = func

end

--[[---------------------------------------------------------
    Remove( number button, any identifier )
    Removes the binding with the given identifier.
-----------------------------------------------------------]]
function bind.Remove( btn, name )

	if not isnumber( btn ) then return end
	if not Bindings[ btn ] then return end

	Bindings[ btn ][ name ] = nil

end

local FirstPressed = {}

hook.Add( "Think", "CallBindings", function()
	for btn, tbl in pairs( Bindings ) do
		local cache = input.IsButtonDown( btn )
		if cache and FirstPressed[ btn ] then
			for _, func in pairs( tbl ) do func() end
		end
		FirstPressed[ btn ] = not cache
	end
end )