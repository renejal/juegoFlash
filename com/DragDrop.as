package  {
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.events.ProgressEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import Jorge.JuegoArrastrar.*;
	import Jorge.Utiles.*;
	
	import gs.TweenLite;
	import gs.easing.*;
	
	
	
	public class DragDrop extends MovieClip {
		//variables de funcionamiento
		private var loader:URLLoader;
		private var datos:XML;
		private var fase:Fase;
		private var fases:Array = new Array();
		private var clipsFases:Array = new Array();
		private var indice:uint = 0;
		private var texto_enunciado:String = "";
		private var texto_descripcion:String = "";
		private var textoHelp:TextoHelp = null;
		
		//variables de configuración
		private var urlDatos:String = "xml/dragDrop.xml";
		
		public function DragDrop() {
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
			var _fases:XMLList = datos..fase;
			fases = new Array();
			for each (var item:XML in _fases){
				fases.push(item);
			}
			Tools.randomiza(fases);
			
			texto_enunciado = Globales.literales.(@id == "texto_enunciado")[0].toString();
			texto_descripcion = Globales.literales.(@id == "texto_descripcion")[0].toString();
			
			gotoAndStop("intro");
			
		}
		
		
		
		
		/*********   funcionaes relacionadas con la intro del juego ***********/
		public function cargaIntro():void{
			onDibujaIntro();
		}
		
		private function onDibujaIntro():void{
			enunciado.htmlText = texto_enunciado;
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
			if(clipsFases.length > 0){
				for(var i:uint = 0; i< clipsFases.length; i++){
					clipsFases[i].destroy();
				}
				clipsFases = new Array();
			}
			Tools.randomiza(fases);
			
			for(i = 0; i< fases.length; i++){
				var _fase:Fase = new Fase(fases[i]);
				clipsFases.push(_fase);
			}
			
			indice = 0;
			
			onDibujaJuego();
		}
		private function onDibujaJuego():void{
			creaFase();
				
			onListenersJuego();
		}
		
		public function creaFase():void{
			if(fase != null){
				removeChild(fase);
			}
			if(indice < fases.length){
				fase = clipsFases[indice];
				addChild(fase);
				enunciado.text = fase.enunciado;
				
				b_anterior.visible = indice != 0;
				indice ++;
			}else{
				fase = null;
				lanzarGameOver();
			}
			
		}
		
		private function _anterior(evento:MouseEvent):void{
			indice -= 2;
			creaFase();
		}
		
		private function _siguiente(evento:MouseEvent):void{
			creaFase();
		}
		
		
		private function onListenersJuego():void{
			b_help.addEventListener(MouseEvent.CLICK, _creaHelp);
			
			b_siguiente.addEventListener(MouseEvent.CLICK ,_siguiente);
			b_anterior.addEventListener(MouseEvent.CLICK, _anterior);
		}
		
		
		private function lanzarGameOver():void{
			gotoAndStop("gameOver");
		}
		/**************************************************************/
		
		
		
		
		/*********  apartado gameover ***********/
		public function cargaGameOver():void{
			onDibujaGameOver();
		}
		private function onDibujaGameOver():void{
			controlResultados();
			
			onListenersGameOver();
		}
		
		private function onListenersGameOver():void{
			b_volver.addEventListener(MouseEvent.CLICK, repetir);
		}
		
		private function repetir(evento:MouseEvent):void{
			gotoAndStop("play");
		}
		
		
		private function controlResultados():void{
			var _ok:uint = 0;
			var _ko:uint = 0;
			for(var i:uint = 0; i< clipsFases.length; i++){
				var _fase:Fase = clipsFases[i];
				for(var iP:uint = 0; iP< _fase.clipPreguntas.numChildren; iP++){
					var pregunta:Pregunta =  _fase.clipPreguntas.getChildAt(iP) as Pregunta;
					if(pregunta.resultado){
						_ok ++;
					}else{
						_ko ++;
					}
				}
			}
			
			ok.text = String(_ok);
			ko.text = String(_ko);
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





