/*	****************************************************************************
		Cocktail ActionScript Full Stack Framework. Copyright (C) 2009 Codeine.
	****************************************************************************
   
		This library is free software; you can redistribute it and/or modify
	it under the terms of the GNU Lesser General Public License as published
	by the Free Software Foundation; either version 2.1 of the License, or
	(at your option) any later version.
		
		This library is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
	or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
	License for more details.

		You should have received a copy of the GNU Lesser General Public License
	along with this library; if not, write to the Free Software Foundation,
	Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	-------------------------
		Codeine
		http://codeine.it
		contact@codeine.it
	-------------------------
	
*******************************************************************************/

package cocktail.core.gunz 
{
	import cocktail.core.gunz.Bullet;				

	/**
	 * Base Trigger class.
	 * @author nybras | nybras@codeine.it
	 */
	public class Trigger 
	{
		/* ---------------------------------------------------------------------
			CONSTANTS
		--------------------------------------------------------------------- */
		
		private static const _LISTEN : String = "listen";
		private static const _UNLISTEN : String = "unlisten";
		
		
		
		/* ---------------------------------------------------------------------
			VARS
		--------------------------------------------------------------------- */
		
		private var _mode : String;
		private var _cached : Array;
		private var _times : Number;
		
		internal var _owner : *;
		internal var _listeners : Array;
		
		
		
		/* ---------------------------------------------------------------------
			INITIALIZING
		--------------------------------------------------------------------- */
		
		/**
		 * Crates a new Trigger for the given owner.
		 * @param owner	Trigger owner.
		 */
		public function Trigger( owner : * ) : void
		{
			_owner = owner;
			_cached = [];
			_listeners = [];
		}

		
		
		/* ---------------------------------------------------------------------
			TIMES / ONCE / LISTEN / UNLISTEN / HANDLE
		--------------------------------------------------------------------- */
		
		/**
		 * Define the number of times the previously listeners -- called after
		 * the last "listen" call -- should live.
		 * @param times	If <code>-1</code> its infinite ( default ) as usual,
		 * otherwise the listeners will work just for the given number of times
		 * and after that its automagicaly destroyed.
		 * @return	The trigger reference for re-use.
		 */
		public function times( times : Number ) : Trigger
		{
			var i : uint;
			
			if( _cached.length )
				do
				{
					Finger( _cached[ i ] )._times = times;
				}
				while( ++i < _cached.length );
			
			_times = times;
			_cached = [];
			
			return this;
		}
		
		/**
		 * Auto destroy all previously listeners -- called after the last
		 * "listen" call -- after its first execution, it is, you don't need
		 * to worry about removing listeners.
		 * @return	The trigger reference for re-use.
		 */
		public function once() : Trigger
		{
			times( 1 );
			return this;
		}
		
		/**
		 * Start listening.
		 * @return	The trigger reference for re-use.
		 */
		public function get listen() : Trigger
		{
			_mode = _LISTEN;
			_times = -1;
			_cached = [];
			return this;
		}
		
		/**
		 * Stop listening.
		 * @return	The trigger reference for re-use.
		 */
		public function get unlisten() : Trigger
		{
			_mode = _UNLISTEN;
			return this;
		}
		
		/**
		 * Handles the subsequent calls after listen/unlisten.
		 * @param type	Bullet tupe to handle.
		 * @param handler	Bullet handler.
		 * @param params	Bullet params.
		 */
		public function handle(
			type : String,
			handler : Function,
			params : * = null
		) : void
		{
			if( _mode == _LISTEN )
				_collect( type, handler, params );
			else if( _mode == _UNLISTEN )
				_purge( type, handler );
		}
		
		
		
		/* ---------------------------------------------------------------------
			COLLECT / PURGE
		--------------------------------------------------------------------- */
		
		/**
		 * Collect Bullet and keep track of Fingers that will pull the Trigger.
		 * @param type	Bullet type.
		 * @param handler	Bullet handler.
		 * @param params	Bullet params.
		 */
		private function _collect(
			type : String,
			handler : Function,
			params : Array
		) : void
		{
			 _cached[ _cached.length ] = _listeners[ _listeners.length ] = (
			 	new Finger(
					_listeners.length,
					this,
					type,
					handler,
					params,
					_times
			 	)
			 );
		}
		
		/**
		 * Purge collected Bullet / Fingers.
		 * @param type	Bullet type to purge.
		 * @param handler	Bullet handler to purge.
		 */
		private function _purge( type : String, handler : Function ) : void
		{
			var finger : Finger;
			var i : uint;
			
			if( _listeners.length )
				do
				{
					finger = Finger( _listeners[ i ] );
					if( finger._type == type && finger._handler == handler )
					{
						finger.release();
						break;
					}
				}
				while( ++i < _listeners.length );
		}
		
		
		
		/* ---------------------------------------------------------------------
			LISTENER HANDLERS
		--------------------------------------------------------------------- */
		
		/**
		 * Remove bullets listener, must to be used after an "unlisten" call.
		 * @param type	If informed, removes all ALL bullets of the given type,
		 * otherwise <code>null</code> removes all bullets of all types.
		 */
		public function all( type : String = null ) : void
		{
			var finger : Finger;
			var i : uint;
			
			if( _listeners.length )
				do
				{
					finger = Finger( _listeners[ i ] );
					if( type == null || finger._type == type )
							finger.release();
				}
				while( ++i < _listeners.length );
		}
		
		/**
		 * Check if the there's some active Bullet/Finger, based on the given
		 * type and / or handler.
		 * @param type	Type to check the existence of bullets listeners.
		 * @param handler	If informed, check if there's a specifically
		 * bullet listener with the given type and handler, otherwise compares
		 * just the given type.
		 * @return	<code>true</code> if found, <code>false</code> otherwise.
		 */
		public function has(
			type : String,
			handler : Function = null
		) : Boolean
		{
			var finger : Finger;
			var found : Boolean;
			var i : uint;
			
			if( _listeners.length )
				do
				{
					finger = Finger( _listeners[ i ] );
					if( finger._type == type  )
						if( handler == null || handler == finger._handler )
						{
							found = true;
							break;
						}
				}
				while( ++i < _listeners.length );
			
			
			return found;
		}
		
		
		
		/* ---------------------------------------------------------------------
			PULL
		--------------------------------------------------------------------- */
		
		/**
		 * Pull the trigger shooting the given bullet.
		 * @param bullet	Bullet to be shoot.
		 */
		public function pull( bullet : Bullet  ) : void
		{
			var finger : Finger;
			var i : uint;
			
			if( _listeners.length )
				do
				{
					finger = Finger( _listeners[ i ] );
					if( finger._type == bullet.type )
							finger.pull( bullet );
				}
				while( ++i < _listeners.length );
		}
	}
}