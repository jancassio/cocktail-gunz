package user.gunz 
{
	import cocktail.core.gunz.Trigger;					

	/**
	 * UserBullet example class.
	 * @author nybras | nybras@codeine.it
	 */
	public class UserTrigger extends Trigger
	{
		/* ---------------------------------------------------------------------
			BULLET TYPES
		--------------------------------------------------------------------- */
		
		public static const UPDATE : String = "update";
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		 
		/**
		 * Creates a new UserTrigger.
		 * @param owner	Trigger owner.
		 */
		public function UserTrigger  ( owner : * )
		{
			super ( owner );
		}
		
		
		
		/* ---------------------------------------------------------------------
			EVENT LISTENERS
		--------------------------------------------------------------------- */
		
		/**
		 * Start/stop listening for UPDATE bullets.
		 * @param hanlder	Bullet handler.
		 * @param params	Bullet params.
		 * @return	A reference to the UserTrigger itself, for inline reuse.
		 */
		public function update (
			handler : Function,
			params : * = null
		) : UserTrigger
		{
			handle( UPDATE, handler, params );
			return this;
		}
	}
}