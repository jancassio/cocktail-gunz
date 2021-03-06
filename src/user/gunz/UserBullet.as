package user.gunz 
{
	import cocktail.core.gunz.Bullet;			

	/**
	 * UserBullet example class.
	 * @author nybras | nybras@codeine.it
	 */
	public class UserBullet extends Bullet
	{
		/* ---------------------------------------------------------------------
			BULLET PROPERTIES
		--------------------------------------------------------------------- */
		
		public var name : String;
		public var gender : String;
		public var age : uint;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new UserBuller.
		 * @param type	Bullet type.
		 * @param name	User name.
		 * @param gender	User gender.
		 * @param age	User age.
		 */
		public function UserBullet (
			type : String,
			name : String,
			gender : String,
			age : uint
		) : void
		{
			super ( type );
			
			this.name = name;
			this.gender = gender;
			this.age = age;
		}
	}
}
