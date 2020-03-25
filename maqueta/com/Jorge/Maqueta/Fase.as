package  Jorge.Maqueta{
	import flash.display.Sprite;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import Jorge.Utiles.*;
	
	import gs.TweenLite;
	import gs.easing.*;
	
	public class Fase extends Sprite{
		private var datos:XML;
		
		

		public function Fase(_datos:XML) {
			onInicio(_datos);
		}
		
		private function onInicio(_datos:XML):void{
			datos = _datos;
			
			onListeners();
		}
		
		private function onListeners():void{
			
		}
		
		public function reset():void{
			
		}
	}
	
}
