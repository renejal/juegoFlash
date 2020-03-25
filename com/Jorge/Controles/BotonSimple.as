package Jorge.Controles {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class BotonSimple extends MovieClip {
		public var funcion:Function = null;
		
		public function BotonSimple() {
			onInicio();
		}
		
		private function onInicio():void{
			stop();
			
			this.buttonMode = true;
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			onDibuja();
		}
		
		private function onDibuja():void{
			onListeners();
		}
		
		private function onListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
			
			this.addEventListener(MouseEvent.CLICK, _click);
		}
		
		
		private function _over(evento:MouseEvent):void{
			gotoAndStop(2);
		}
		
		private function _out(evento:MouseEvent):void{
			gotoAndStop(1);
		}
		
		private function _click(evento:MouseEvent):void{
			if(funcion != null){
				funcion(evento);
			}
		}
	}
	
}
