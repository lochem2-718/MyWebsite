
// better log function

export function log( item, label = '' )
{
    if( typeof label !== 'string' )
    {
        InvalidArgumentException()
    }
    
    if( label === '' )
    {
        console.log( item )
    }
    else
    {
        console.log( label + ' : ' + item )
    }
    return item
}

// exceptions

export function ElementDNEException()
{
    throw 'Element does not exist!'
}

export function InvalidArgumentException()
{
    throw 'Invalid Argument!'
}