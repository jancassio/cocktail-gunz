package user 
{
	import user.gunz.UserBullet;
	import user.gunz.UserTrigger;	

	/**
	 * User example class.
	 * @author nybras | nybras@codeine.it
	 */
	public class User
	{
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		public var trigger : UserTrigger;
		
		public var name : String;
		public var gender : String;
		public var age : uint;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new user.
		 */
		public function User ()
		{
			trigger = new UserTrigger ( this );
		}
		
		
		/* ---------------------------------------------------------------------
			BULLET/TRIGGER IMPLEMENTATION ( listen/unlisten )
		--------------------------------------------------------------------- */
		
		/*
		 * THESE TWO GETTERS BELOW MUST TO BE IMPLEMENTED IN EVERY CLASS THAT
		 * WILL USE TRIGGER/BULLETS, IN ORDER TO OFFER STRICT AUTO-COMPLETE AND
		 * VALIDATION.  
		 */
		
		/**
		 * Start listening.
		 * @return	The trigger <code>UserTrigger</code> reference.
		 */
		public function get listen () : UserTrigger
		{
			return UserTrigger ( trigger.listen );
		}
		
		/**
		 * Stop listening.
		 * @return	The trigger <code>UserTrigger</code> reference.
		 */
		public function get unlisten () : UserTrigger
		{
			return UserTrigger ( trigger.unlisten );
		}
		
		
		
		/* ---------------------------------------------------------------------
			UPDATING USER ( and pulling trigger )
		--------------------------------------------------------------------- */
		
		/**
		 * Update the user data.
		 * @param name	User name.
		 * @param gender	User gender.
		 * @param age	User age.
		 */
		public function update (
			name : String,
			gender : String,
			age : uint
		) : void
		{
			this.name = name;
			this.gender = gender;
			this.age = age;
			
			trigger.pull( new UserBullet(
				UserTrigger.UPDATE, name, gender, age
			) );
		}
	}
}