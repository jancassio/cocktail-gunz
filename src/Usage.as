package  
{
	import user.User;
	import user.gunz.UserBullet;

	import flash.display.Sprite;

	/**
	 * Usage example of a Trigger / Finger / Bullet (event) flow.
	 * @author nybras | nybras@codeine.it
	 */
	public class Usage extends Sprite
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _user : User;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a Usage instance.
		 */
		public function Usage ()
		{
			// new user
			_user = new User ();
			
			// listening for update, only for TWO times (and expires after that)
			_user.listen.update ( update, [ "params...", 1, 2, 3 ] ).times( 2 );
			
			// updating user (this fires the update bullet)
			_user.update( "nybras", "m", 24 );
			_user.update( "jan", "m", 28 );
			
			// now the listener has expired and so it won't listen this update
			_user.update( "carlos", "m", 23 );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Listens for user bullets.
		 * @param bullet	UserBullet.UPDATE.
		 */
		public function update ( bullet : UserBullet ) : void
		{
			trace ( "--------------------" );
			trace ( bullet +":"+ bullet.type );
			trace ( "--------------------" );
			trace ( bullet.name );
			trace ( bullet.age );
			trace ( bullet.gender );
			trace ( bullet.params );
		}
	}
}