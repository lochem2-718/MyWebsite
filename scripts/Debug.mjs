// better log function

export function log( item, description = "" )
{
    console.log( description + " : " + item );
    return item;
}

// exceptions

export function ElementDNEException()
{
    throw "Element does not exist!";
}

export function InvalidArgumentException()
{
    throw "Invalid Argument!";
}