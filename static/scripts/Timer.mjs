
export class Timer
{
    constructor()
    {
        this._seconds = 0;
        this._jobId = 0;
    }

    start()
    {
        this.reset();
        this.resume();
    }

    resume()
    {
        if( this._jobId === 0 )
        {
            this._jobId = window.setInterval( () => { this._seconds = this._seconds + 1 }, 1000 );
        }
    }

    reset()
    {
        this.stop();
        this._seconds = 0;
    }

    stop()
    {
        if( this._jobId !== 0 )
        {
            window.clearInterval( this._jobId );
            this._jobId = 0;
        }
    }

    get minutes()
    {
        return Math.floor( this._seconds / 60 );
    }

    get seconds()
    {
        return this._seconds % 60;
    }

    get hours()
    {
        return Math.floor( this._seconds / ( 60 * 60 ) );
    }

    get days()
    {
        return Math.floor( this._seconds / ( 60 * 60 * 24 ) );
    }
}