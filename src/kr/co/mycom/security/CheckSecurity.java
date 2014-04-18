package kr.co.mycom.security;

import java.text.CharacterIterator;
import java.text.StringCharacterIterator;

public class CheckSecurity {

	public String replaceTagToText(String inputStr) {

		if(inputStr == null) {
			return null;
		} else {
	/*		inputStr = inputStr.replaceAll("&", "&amp;");	
			inputStr = inputStr.replaceAll("<", "&lt;");	
			inputStr = inputStr.replaceAll(">", "&gt;");	
			inputStr = inputStr.replaceAll("'", "''");	
			inputStr = inputStr.replaceAll("!", "&#33;");	
			inputStr = inputStr.replaceAll("\"", "&#34;");//큰따옴표(")	
			inputStr = inputStr.replaceAll("#", "&#35;");	
			inputStr = inputStr.replaceAll("$", "&#36;");	
			inputStr = inputStr.replaceAll("%", "&#37;");	
			inputStr = inputStr.replaceAll("&", "&#38;");
		*/
			
			final StringBuilder result = new StringBuilder();
		     final StringCharacterIterator iterator = new StringCharacterIterator(inputStr);
		     char character =  iterator.current();
		     while (character != CharacterIterator.DONE ){
		       if (character == '<') {
		         result.append("&lt;");
		       }
		       else if (character == '>') {
		         result.append("&gt;");
		       }
		       else if (character == '&') {
		         result.append("&amp;");
		      }
		       else if (character == '\"') {
		         result.append("&quot;");
		       }
		       else if (character == '\t') {
		         addCharEntity(9, result);
		       }
		       else if (character == '!') {
		         addCharEntity(33, result);
		       }
		       else if (character == '#') {
		         addCharEntity(35, result);
		       }
		       else if (character == '$') {
		         addCharEntity(36, result);
		       }
		       else if (character == '%') {
		         addCharEntity(37, result);
		       }
		       else if (character == '\'') {
		         addCharEntity(39, result);
		       }
		       else if (character == '(') {
		         addCharEntity(40, result);
		       }
		       else if (character == ')') {
		         addCharEntity(41, result);
		       }
		       else if (character == '*') {
		         addCharEntity(42, result);
		       }
		       else if (character == '+') {
		         addCharEntity(43, result);
		       }
		       else if (character == ',') {
		         addCharEntity(44, result);
		       }
		       else if (character == '-') {
		         addCharEntity(45, result);
		       }
		       else if (character == '.') {
		         addCharEntity(46, result);
		       }
		       else if (character == '/') {
		         addCharEntity(47, result);
		       }
		       else if (character == ':') {
		         addCharEntity(58, result);
		       }
		       else if (character == ';') {
		         addCharEntity(59, result);
		       }
		       else if (character == '=') {
		         addCharEntity(61, result);
		       }
		       else if (character == '?') {
		         addCharEntity(63, result);
		       }
		       else if (character == '@') {
		         addCharEntity(64, result);
		       }
		       else if (character == '[') {
		         addCharEntity(91, result);
		       }
		       else if (character == '\\') {
		    	   /*char nextCharacter = iterator.next();
		    	   if(nextCharacter == '"' || nextCharacter == 't'  || nextCharacter == '\''  || nextCharacter == '\\' ){
		    	   } else {*/
		    		   addCharEntity(92, result);
	/*	    	   }
		    	   character = iterator.previous();*/
		       }
		       else if (character == ']') {
		         addCharEntity(93, result);
		       }
		       else if (character == '^') {
		         addCharEntity(94, result);
		       }
	/*	       else if (character == '_') {
		         addCharEntity(95, result);
		         System.out.println(result + "\n");
		       }*/
		       else if (character == '`') {
		         addCharEntity(96, result);
		       }
		       else if (character == '{') {
		         addCharEntity(123, result);
		       }
		       else if (character == '|') {
		         addCharEntity(124, result);
		       }
		       else if (character == '}') {
		         addCharEntity(125, result);
		       }
		       else if (character == '~') {
		         addCharEntity(126, result);
		       }
		       else {
		         //the char is not a special one
		         //add it to the result as is
		         result.append(character);
		       }
	//	       System.out.println(result + "\n");
		       character = iterator.next();
		     }
	
			return result.toString();
		}
	}

	public String getText(String inputStr) {
		
		/*inputStr = inputStr.replaceAll("&lt;", "<");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&gt;", ">");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("''", "'");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&amp;", "&");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#033;", "!");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#035;", "#");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#036;", "$");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#037;", "%");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#038;", "&");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#039;", "'");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#040;", "(");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#041;", ")");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#042;", "*");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#043;", "+");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#044;", ",");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#045;", "-");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#046;", ".");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#047;", "/");
        System.out.println(inputStr + "\n");
		inputStr = inputStr.replaceAll("&#058;", ":");
		inputStr = inputStr.replaceAll("&#059;", ";");
		inputStr = inputStr.replaceAll("&#060;", "<");
		inputStr = inputStr.replaceAll("&#061;", "=");
		inputStr = inputStr.replaceAll("&#062;", ">");
		inputStr = inputStr.replaceAll("&#063;", "?");
		inputStr = inputStr.replaceAll("&#091;", "[");
		inputStr = inputStr.replaceAll("&#093;", "]");
		inputStr = inputStr.replaceAll("&#094;", "^");
		inputStr = inputStr.replaceAll("&#095;", "_");
		inputStr = inputStr.replaceAll("&#096;", "`");

		inputStr = inputStr.replaceAll("&#092;", "\\");
		inputStr = inputStr.replaceAll("&quot;", "\"");		// inputStr = inputStr.replaceAll(Chr(13)&Chr(10), "<br>");	
		*/
//		System.out.println("inputStr : " + inputStr + "		length : " + inputStr.length()+"\n");
		inputStr = inputStr.replaceAll("&lt;", "<");
		inputStr = inputStr.replaceAll("&gt;", ">");
		inputStr = inputStr.replaceAll("&amp;", "&");
		inputStr = inputStr.replaceAll("&quot;", "\"");
		inputStr = inputStr.replaceAll("&#009;", "\t");
		inputStr = inputStr.replaceAll("&#033;", "!");
		inputStr = inputStr.replaceAll("&#035;", "#");
//		inputStr = inputStr.replaceAll("&#036;", "$");
		inputStr = inputStr.replaceAll("&#037;", "%");
		inputStr = inputStr.replaceAll("&#039;", "\'");
		inputStr = inputStr.replaceAll("&#040;", "(");
		inputStr = inputStr.replaceAll("&#041;", ")");
		inputStr = inputStr.replaceAll("&#042;", "*");
		inputStr = inputStr.replaceAll("&#043;", "+");
		inputStr = inputStr.replaceAll("&#044;", ",");
		inputStr = inputStr.replaceAll("&#045;", "-");
		inputStr = inputStr.replaceAll("&#046;", ".");
		inputStr = inputStr.replaceAll("&#047;", "/");
		inputStr = inputStr.replaceAll("&#058;", ":");
		inputStr = inputStr.replaceAll("&#059;", ";");
		inputStr = inputStr.replaceAll("&#061;", "=");
		inputStr = inputStr.replaceAll("&#063;", "?");
		inputStr = inputStr.replaceAll("&#064;", "@");
		inputStr = inputStr.replaceAll("&#091;", "[");
//		inputStr = inputStr.replaceAll("&#092;", "\\");
		inputStr = inputStr.replaceAll("&#093;", "]");
		inputStr = inputStr.replaceAll("&#094;", "^");
//		inputStr = inputStr.replaceAll("&#095;", "_");
		inputStr = inputStr.replaceAll("&#096;", "`");
		inputStr = inputStr.replaceAll("&#123;", "{");
		inputStr = inputStr.replaceAll("&#124;", "|");
		inputStr = inputStr.replaceAll("&#125;", "}");
		inputStr = inputStr.replaceAll("&#126;", "~");

		return inputStr;
	}

	public String preventXSS(String inputStr) {
		inputStr = inputStr.replaceAll("<", "&lt;"); // 태그를 무력화시킵니다.
		inputStr = inputStr.replaceAll(">", "&gt;"); // 이렇게 바꾸게되면 코드가 실행되지 않고
														// 그대로 출력됩니다.
		// 개행이나 문단정렬에 관련된 html태그는 허용해줍니다.
		inputStr = inputStr.replaceAll("&lt;p&gt;", "<p>");
		inputStr = inputStr.replaceAll("&lt;P&gt;", "<P>");
		inputStr = inputStr.replaceAll("&lt;br&gt;", "<br>");
		inputStr = inputStr.replaceAll("&lt;BR&gt;", "<BR>");
		return inputStr;
	}

	public String preventLDAP_Injection(String inputStr) {
		inputStr = inputStr.replaceAll("\\\\", "");
		inputStr = inputStr.replaceAll("\\*", "");
		inputStr = inputStr.replaceAll("(", "");
		inputStr = inputStr.replaceAll(")", "");
		inputStr = inputStr.replaceAll(";", "");
		inputStr = inputStr.replaceAll(",", "");
		inputStr = inputStr.replaceAll("*", "");
		inputStr = inputStr.replaceAll("|", "");
		inputStr = inputStr.replaceAll("&", "");
		inputStr = inputStr.replaceAll("=", "");
		inputStr = inputStr.replaceAll("%", "");

		return inputStr;
	}
	
	private static void addCharEntity(Integer aIdx, StringBuilder aBuilder){
	    String padding = "";
	    if( aIdx <= 9 ){
	       padding = "00";
	    }
	    else if( aIdx <= 99 ){
	      padding = "0";
	    }
	    else {
	      //no prefix
	    }
	    String number = padding + aIdx.toString();
	    aBuilder.append("&#" + number + ";");
	  }
	
	
	
}
