﻿/**
 * ...
 * @author $(DefaultUser)
 */

package htemplate;

import htemplate.HTemplateParser;

class ScriptBuilder 
{
	private var context : String;
	private var concatMethod : String;

	public function new(context : String, concatMethod : String)
	{
		this.context = context;
		this.concatMethod = concatMethod;
	}
	
	public function build(blocks : Array<TBlock>) : String
	{
		var buffer = new StringBuf();
		
		for(block in blocks)
		{
			buffer.add(blockToString(block));
		}
		
		return buffer.toString();
	}
	
	public function blockToString(block : TBlock) : String
	{
		var output = context + '.' + concatMethod + '(';
		
		switch(block)
		{
			case literal(s):
				return context + '.' + concatMethod + "('" + StringTools.replace(s, "'", "\\'") + "');\n";
			
			case ifBlock(s):
				return "if(" + s + ") {\n";

			case elseifBlock(s):
				return "} elseif(" + s + ") {\n";

			case elseBlock:
				return "} else {\n";

			case closeBlock:
				return "}\n";
				
			case forBlock(s):
				return "for(" + s + ") {\n";
				
			case codeBlock(s):
				throw 'Not implemented.';
			
			case printBlock(s):
				return context + '.' + concatMethod + "(" + s + ");\n";
		}		
	}
}