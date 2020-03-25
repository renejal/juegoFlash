package Jorge.Utiles
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class Tools
	{
		public function Tools()
		{
		}
		
		
		//pone al frente al clip
		public static function ponAlFrente(quien:DisplayObject):void{
			var __parent:DisplayObjectContainer = quien.parent as DisplayObjectContainer;
			__parent.swapChildrenAt(__parent.numChildren-1, __parent.getChildIndex(quien));
		}
		
		
		//elimina los childs de un clip
		public static function vaciaClip(elemento:DisplayObjectContainer):void{
			var tope:uint = elemento.numChildren;
			for(var i:uint = 0; i<tope; i++){
				elemento.removeChildAt(0);
			}
		}
		
		
		//randomiza un array
		public static function randomiza(lista:Array):Array{
			for(var i:uint=0; i<5; i++){
				lista.sort(randomArray);
			}
			return lista;
		}
		private static function randomArray(a:Object, b:Object):Number{
			return Math.round(2*Math.random()) - 1;
		}
		
	}
}





