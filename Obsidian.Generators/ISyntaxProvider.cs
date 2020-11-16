﻿using Microsoft.CodeAnalysis;
using System.Collections.Generic;

namespace Obsidian.Generators
{
    public interface ISyntaxProvider<out T> : ISyntaxReceiver where T : SyntaxNode
    {
        public IEnumerable<T> GetSyntaxNodes();
        public ISyntaxProvider<T> WithContext(GeneratorExecutionContext context);
    }
}
