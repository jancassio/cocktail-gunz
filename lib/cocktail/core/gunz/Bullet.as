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
	import flash.utils.describeType;	
	
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
		public function Bullet( type : String ) : void
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
		public function get type() : String
		{
			return _type;	
		}
		
		/**
		 * Get the event params.
		 * @return	The event params.
		 */
		public function get params() : *
		{
			return _params;
		}
		
		/**
		 * Get the event owner.
		 * @return	The target where bullets is dispatched from.
		 */
		public function get owner() : *
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
		internal function set_params( params : * ) : void
		{
			_params = params;
		}
		
		/**
		 * Set the event owner.
		 * @param owner	The target where bullets is dispatched from.
		 */
		internal function set_owner( owner : * ) : void
		{
			_owner = owner; 
		}
		
		
		
		/* ---------------------------------------------------------------------
			TO STRING CONVERSION
		--------------------------------------------------------------------- */
		
		/**
		 * Format all public properties to String.
		 * @param	The bullet into String format.
		 */
		public function toString() : String
		{
			var output : String;
			var described : XML;
			var props : XMLList;
			var prop : XML;
			
			described = describeType( this );
			output = "[object "+ described.@name.split( "::" ).pop() +"]\n{\n";
			props = described..variable; 
			
			for each( prop in props )
			{
				output += "\t"+ prop.@name +" : ";
				output += prop.@type.split( "::" ).pop() +" = ";
				output += this[ prop.@name ];
			}
			
			return output +"\n}";
		}
	}
}