package cocktail.core.gunz 
{
	/**
	 * Base Bullet class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Bullet 
	{
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _type : String;
		private var _params : *;
		private var _owner : *;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Creates a new Bullet with the given type.
		 * @param type	Event type to be created.
		 */
		public function Bullet ( type : String ) : void
		{
			_type = type;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PUBLIC GETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Get the bullet type.
		 * @return	The bullet type.
		 */
		public function get type () : String
		{
			return _type;	
		}
		
		/**
		 * Get the event params.
		 * @return	The event params.
		 */
		public function get params () : *
		{
			return _params;
		}
		
		/**
		 * Get the event owner.
		 * @return	The target where bullets is dispatched from.
		 */
		public function get owner () : *
		{
			return _owner;
		}
		
		
		
		/* ---------------------------------------------------------------------
			INTERNAL SETTERS
		--------------------------------------------------------------------- */
		
		/**
		 * Set the event params.
		 * @param params	Params to be added into the event.
		 */
		internal function set_params ( params : * ) : void
		{
			_params = params;
		}
		
		/**
		 * Set the event owner.
		 * @param owner	The target where bullets is dispatched from.
		 */
		internal function set_owner ( owner : * ) : void
		{
			_owner = owner; 
		}
	}
}