package Jorge.JuegoArrastrar {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.errors.IOError;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import Jorge.Utiles.*;
	
	public class Respuesta extends MovieClip {
		private var datos:XML;
		private var seleccionado:Boolean = false;
		public var ref:Fase;
		public var id:String;
		private var loader:Loader;
		public var clip:MovieClip = new MovieClip();
		public var pregunta:Pregunta = null;
		
		public var posX0:Number;
		public var posY0:Number;
		
		public function Respuesta(_datos:XML, _ref:Fase) {
			onInicio(_datos, _ref);
		}
		
		private function onInicio(_datos:XML, _ref:Fase):void{
			stop();
			
			datos = _datos;
			ref = _ref;
			this.id = datos.@id;
			
			addEventListener(Event.ADDED_TO_STAGE, onDibuja);
		}
		
		private function onDibuja(evento:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE, onDibuja);
			desactiva();
			
			loader = new Loader();
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(new URLRequest(datos.toString()));
			
			onListeners();
		}
		
		private function onProgress(evento:ProgressEvent):void{
			trace(evento.bytesLoaded + " de " + evento.bytesTotal);
		}
		
		private function onComplete(evento:Event):void{
			clip.addChild(loader);
			addChild(clip);
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			
			clip.buttonMode = true;
			clip.useHandCursor = true;
			clip.mouseChildren = false;
			clip.addEventListener(MouseEvent.MOUSE_DOWN, _down);
		}
		
		
		private function onError(evento:IOErrorEvent):void{
			trace("error de carga de clip externo: " + evento.text);
		}
		
		private function onListeners():void{
			this.addEventListener(MouseEvent.MOUSE_OVER, _over);
			this.addEventListener(MouseEvent.MOUSE_OUT, _out);
		}
		
		public function _over(evento:MouseEvent):void{
			alpha = 1;
		}
		
		private function _out(evento:MouseEvent):void{
			//if(!seleccionado){
				alpha = 0.7;
			//}else{
				//alpha = 1;
			//}
		}
		
		public function activa():void{
			alpha = 1;
			seleccionado = true;
		}
		
		public function desactiva():void{
			alpha = 0.7;
			//seleccionado = false;
		}
		
		private function _down(evento:MouseEvent):void{
			this.startDrag();
			this.stage.addEventListener(MouseEvent.MOUSE_UP, _up);
			Tools.ponAlFrente(this);
			Mouse.cursor = MouseCursor.HAND;
		}
		
		private function _up(evento:MouseEvent):void{
			this.stopDrag();
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, _up);
			
			ref.controlUp(this);
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		public function almacenaPosicion():void{
			posX0 = this.x;
			posY0 = this.y;
		}
		
		public function recoloca():void{
			this.x = posX0;
			this.y = posY0;
		}
		
		public function destroy():void{
			this.removeEventListener(MouseEvent.MOUSE_OVER, _over);
			this.removeEventListener(MouseEvent.MOUSE_OUT, _out);
		}
	}
	
}
