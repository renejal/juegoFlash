package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import Jorge.Maqueta.*;
	import Jorge.Utiles.*;
	
	import gs.TweenLite;
	import gs.easing.*;
	
	
	
	public class Maqueta extends MovieClip {
		//variables de funcionamiento
		private var loader:URLLoader;
		private var datos:XML;
		private var fases:XMLList;
		
		private var texto_enunciado:String = "";
		private var texto_descripcion:String = "";
		private var textoHelp:TextoHelp = null;
		
		
		private var indice:uint = 0;
		private var fase:Fase;
		
		//variables de configuración
		private var urlDatos:String = "xml/maqueta.xml";
		
		public function Maqueta() {
			stop();
			onInicio();
		}
		
		private function onInicio():void{
			Globales.__root = this;
			
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onDatosCargados);
			loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.load(new URLRequest(urlDatos));
		}
		
		private function onProgress(evento:ProgressEvent):void{
			trace(evento.bytesLoaded + " de " + evento.bytesTotal);
		}
		
		private function onDatosCargados(evento:Event):void{
			datos = new XML(loader.data);
			
			Globales.literales = datos..literal;
			fases = datos..fase;
			
			
			gotoAndStop("intro");
		}
		
		
		
		
		/*********   funcionaes relacionadas con la intro del juego ***********/
		public function cargaIntro():void{
			onDibujaIntro();
		}
		
		private function onDibujaIntro():void{
			onListenersIntro();
		}
		
		private function onListenersIntro():void{
			b_play.addEventListener(MouseEvent.CLICK,lanzaJuego);
		}
		
		
		private function lanzaJuego(evento:MouseEvent):void{
			gotoAndStop("play");
		}
		
		/**************************************************************/
		
		
		
		/*********   creo el juego ***********/
		public function cargaJuego():void{
			
			onDibujaJuego();
		}
		private function onDibujaJuego():void{
			creaPuzzle();
			onListenersJuego();
		}
		
		private function creaPuzzle():void{
			b_siguiente.visible = false;
			
			fase = new Fase(fases[indice]);
			addChild(fase);
		}
		
		
		
		private function onListenersJuego():void{
			b_siguiente.addEventListener(MouseEvent.CLICK, lanzaSiguiente);
			b_help.addEventListener(MouseEvent.CLICK, _creaHelp);
		}
		
		private function lanzaSiguiente(evento:MouseEvent):void{
			if(indice < fases.length() - 1){
				fase.reset();
				indice ++;
				creaPuzzle();
			}else{
				lanzarGameOver();
			}
		}
		
		private function lanzarGameOver():void{
			removeChild(fase);
			gotoAndStop("gameOver");
		}
		/**************************************************************/
		
		
		
		
		/*********  apartado gameover ***********/
		public function cargaGameOver():void{
			onDibujaGameOver();
		}
		private function onDibujaGameOver():void{
			onListenersGameOver();
		}
		
		private function onListenersGameOver():void{
			b_volver.addEventListener(MouseEvent.CLICK, repetir);
		}
		
		private function repetir(evento:MouseEvent):void{
			indice = 0;
			gotoAndStop("play");
		}
		/**************************************************************/
		
		
		/*********   ayuda ***********/
		private function _creaHelp(evento:MouseEvent):void{
			if(textoHelp == null){
				textoHelp = new TextoHelp();
				textoHelp.texto.htmlText = texto_descripcion;
				textoHelp.addEventListener(MouseEvent.CLICK, _borraHelp);
				addChild(textoHelp);
			}
		}
		
		private function _borraHelp(evento:MouseEvent):void{
			textoHelp.removeEventListener(MouseEvent.CLICK, _borraHelp);
			removeChild(textoHelp);
			textoHelp = null;
		}
		/**************************************************************/
	}
	
}





