package cls 
{
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
    import flash.events.MouseEvent;
	
	
	public class clsIndex extends MovieClip
	{
		private var atrScene1:Loader = null;
		private var atrUrl1:URLRequest = null;
		
		public function clsIndex() 
		{
			// constructor code
				trace("hola");
				
				inicio();
				
				
			}
			private function inicio(){
				b_juego1.funcion = lanzarJuego1;
				b_juego2.funcion = lanzarJuego2;
				
				
				
				
				
			}


 
			private function lanzarJuego2(evento:MouseEvent):void{
				trace("juego2");
				loadSwf("Test.swf");
			}
			private function lanzarJuego1(evento:MouseEvent):void{
				trace("juego1");

				loadSwf("DragDrop.swf");
			}
			private function loadSwf(parNombre:String):void
			{
				
				if(atrScene1 == null){
					atrScene1 = new Loader();
					atrUrl1 = new URLRequest(parNombre);
				}
				else{
					removeChild(atrScene1);
					atrScene1= null;
					atrUrl1 = null;
					atrScene1 = new Loader();
					atrUrl1 = new URLRequest(parNombre);
				}
				
				
				atrScene1.load(atrUrl1);
				addChild(atrScene1);
				
				atrScene1.x = 700;
				atrScene1.y = 150;
				
			}
			
			
			
		
	}
	
}
