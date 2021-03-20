# You started writing a very basic class for handling files. However, when you begin to write some simple test code, you get a NameError. The error message complains of an uninitialized constant File::FORMAT.

# What is the problem and what are possible ways to fix it?

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s ## changed from `FORMAT` to `self.class::FORMAT`
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post

# SG: The issue here is that `FORMAT` is resolved from within `File#to_s`. When a constant is resolved, ruby looks at the surrounding code within `File` (the lexical scope) to see if the constant has been defined. It doesn't find a definition so it then searches up the inheritance ladder to see if any of `File`'s ancestors define a `FORMAT` constant. They don't so then it returns an error. It never checks the subclasses of `File` because those are neither within the lexical scope of, nor the ancestors of, `File` (the location from which the constant was resolved). The solution is to help direct Ruby where to look with explicit namespacing. Since we have different values for the constant for each of the subclasses, we can preface `FORMAT` with `self.class::` so that we call the respective constants.
