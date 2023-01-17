CREATE FUNCTION public.function_copy() RETURNS trigger
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO table2(id, name)
    VALUES (new.id, new.name);

    RETURN new;
END;
$$;