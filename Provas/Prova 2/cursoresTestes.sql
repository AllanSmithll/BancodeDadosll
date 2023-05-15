-- Estudando cursores
-- Com LOOP
DO $$
Declare
	vdesc categoria.desccateg%type;
	vcursor_categ CURSOR for
		Select desccateg from categoria;
Begin
	Open vcursor_categ;
	LOOP
		fetch vcursor_categ into vdesc;
		EXIT when NOT FOUND;
		raise notice 'Nome Categoria = %', vdesc;
	END LOOP;
	Close vcursor_categ;
End$$;

-- Com FOR
DO $$
Declare
	vdesc categoria.desccateg%type;
	vcursor_categ CURSOR for
		Select desccateg from categoria;
Begin
	For vcat IN vcursor_categ LOOP
		vdesc := vcat.desccateg;
		raise notice 'Nome Categoria = %', vdesc;
	END LOOP;
End$$;

-- Parâmetro no Cursor
do $$
Declare
	localpais artista.pais%TYPE;
	c_artista Cursor (v_pais artista.pais%TYPE) for
		Select * From artista where pais = v_pais;
Begin
	localpais := 'Brasil';
	raise notice 'País = %', localpais;
	For vart IN c_artista(localpais) LOOP
		raise notice 'Nome do Artista = %', vart.nomeart;
	End Loop;
End$$;