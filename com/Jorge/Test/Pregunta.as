package Jorge.Test {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import Jorge.Utiles.*;
	import flash.display.Sprite;
	import gs.TweenLite;
	import gs.easing.*;
	
	
	public class Pregunta extends MovieClip {
		public var resultado:Boolean = false;
		private var datos:XML;
		private var respuestas:XMLList;
		private var clipRespuestas:Sprite = new Sprite();
		private var id:String;
		private var correcto:String;
		private var respuestaSel:Respuesta = null;
		
		public function Pregunta(_datos:XML) {
			onInicio(_datos);
		}
		
		private function onInicio(_datos:XML):void{
			datos = _datos;
			correcto = datos.@OK;
			id = datos.@id;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
		}
		
		private function onDibuja(evento:Event):void{
			this.removeEventListener(Event.ADDED_TO_STAGE, onDibuja);
			
			texto.htmlText = datos.enunciado.toString();
			//texto.x = 800;
			//texto.y = 400;
			
			respuestas = datos..respuesta;
			var _respuestas:Array = new Array();
			for each(var item:XML in respuestas){
				_respuestas.push(item);
			}
			_respuestas = Tools.randomiza(_respuestas);
			
			var posY:Number = 0;
			for (var i:uint=0; i< _respuestas.length; i++){
				item = _respuestas[i];
				var respuesta:Respuesta = new Respuesta(item, this);
				respuesta.y = posY;
				respuesta.alpha = 0;
				posY += respuesta.height + 10;
				TweenLite.to(respuesta, 1, {delay:0.6 + i*0.1, alpha:1});
				clipRespuestas.addChild(respuesta);
			}
			clipRespuestas.x = 650;
			clipRespuestas.y = (500 - clipRespuestas.height)/2;
			addChild(clipRespuestas);
			
			onListeners();
		}
		
		public function controlRespuesta(quien:Respuesta):void{
			if(respuestaSel != null){
				respuestaSel.activa();
			}
			this.respuestaSel = quien;
			resultado = quien.id == correcto;
		}
		
		private function onListeners():void{
			
		}
		
		public function destroy():void{
			for(var i:uint=0; i<clipRespuestas.numChildren; i++){
				var respuesta:Respuesta = clipRespuestas.getChildAt(i) as Respuesta;
				respuesta.destroy();
			}
		}
	}
	
}
