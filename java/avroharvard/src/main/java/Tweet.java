
@SuppressWarnings("all")
@org.apache.avro.specific.AvroGenerated
public class Tweet extends org.apache.avro.specific.SpecificRecordBase implements org.apache.avro.specific.SpecificRecord {
  public static final org.apache.avro.Schema SCHEMA$ = new org.apache.avro.Schema.Parser().parse("{\"type\":\"record\",\"name\":\"Tweet\",\"fields\":[{\"name\":\"tweetid\",\"type\":\"int\"},{\"name\":\"user\",\"type\":\"string\"},{\"name\":\"text\",\"type\":\"string\"},{\"name\":\"Hashtags\",\"type\":{\"type\":\"array\",\"items\":\"string\"}}]}");
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }
  @Deprecated public int tweetid;
  @Deprecated public java.lang.CharSequence user;
  @Deprecated public java.lang.CharSequence text;
  @Deprecated public java.util.List<java.lang.CharSequence> Hashtags;

  /**
   * Default constructor.  Note that this does not initialize fields
   * to their default values from the schema.  If that is desired then
   * one should use <code>newBuilder()</code>. 
   */
  public Tweet() {}

  /**
   * All-args constructor.
   */
  public Tweet(java.lang.Integer tweetid, java.lang.CharSequence user, java.lang.CharSequence text, java.util.List<java.lang.CharSequence> Hashtags) {
    this.tweetid = tweetid;
    this.user = user;
    this.text = text;
    this.Hashtags = Hashtags;
  }

  public org.apache.avro.Schema getSchema() { return SCHEMA$; }
  // Used by DatumWriter.  Applications should not call. 
  public java.lang.Object get(int field$) {
    switch (field$) {
    case 0: return tweetid;
    case 1: return user;
    case 2: return text;
    case 3: return Hashtags;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }
  // Used by DatumReader.  Applications should not call. 
  @SuppressWarnings(value="unchecked")
  public void put(int field$, java.lang.Object value$) {
    switch (field$) {
    case 0: tweetid = (java.lang.Integer)value$; break;
    case 1: user = (java.lang.CharSequence)value$; break;
    case 2: text = (java.lang.CharSequence)value$; break;
    case 3: Hashtags = (java.util.List<java.lang.CharSequence>)value$; break;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }

  /**
   * Gets the value of the 'tweetid' field.
   */
  public java.lang.Integer getTweetid() {
    return tweetid;
  }

  /**
   * Sets the value of the 'tweetid' field.
   * @param value the value to set.
   */
  public void setTweetid(java.lang.Integer value) {
    this.tweetid = value;
  }

  /**
   * Gets the value of the 'user' field.
   */
  public java.lang.CharSequence getUser() {
    return user;
  }

  /**
   * Sets the value of the 'user' field.
   * @param value the value to set.
   */
  public void setUser(java.lang.CharSequence value) {
    this.user = value;
  }

  /**
   * Gets the value of the 'text' field.
   */
  public java.lang.CharSequence getText() {
    return text;
  }

  /**
   * Sets the value of the 'text' field.
   * @param value the value to set.
   */
  public void setText(java.lang.CharSequence value) {
    this.text = value;
  }

  /**
   * Gets the value of the 'Hashtags' field.
   */
  public java.util.List<java.lang.CharSequence> getHashtags() {
    return Hashtags;
  }

  /**
   * Sets the value of the 'Hashtags' field.
   * @param value the value to set.
   */
  public void setHashtags(java.util.List<java.lang.CharSequence> value) {
    this.Hashtags = value;
  }

  /** Creates a new Tweet RecordBuilder */
  public static Tweet.Builder newBuilder() {
    return new Tweet.Builder();
  }
  
  /** Creates a new Tweet RecordBuilder by copying an existing Builder */
  public static Tweet.Builder newBuilder(Tweet.Builder other) {
    return new Tweet.Builder(other);
  }
  
  /** Creates a new Tweet RecordBuilder by copying an existing Tweet instance */
  public static Tweet.Builder newBuilder(Tweet other) {
    return new Tweet.Builder(other);
  }
  
  /**
   * RecordBuilder for Tweet instances.
   */
  public static class Builder extends org.apache.avro.specific.SpecificRecordBuilderBase<Tweet>
    implements org.apache.avro.data.RecordBuilder<Tweet> {

    private int tweetid;
    private java.lang.CharSequence user;
    private java.lang.CharSequence text;
    private java.util.List<java.lang.CharSequence> Hashtags;

    /** Creates a new Builder */
    private Builder() {
      super(Tweet.SCHEMA$);
    }
    
    /** Creates a Builder by copying an existing Builder */
    private Builder(Tweet.Builder other) {
      super(other);
      if (isValidValue(fields()[0], other.tweetid)) {
        this.tweetid = data().deepCopy(fields()[0].schema(), other.tweetid);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.user)) {
        this.user = data().deepCopy(fields()[1].schema(), other.user);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.text)) {
        this.text = data().deepCopy(fields()[2].schema(), other.text);
        fieldSetFlags()[2] = true;
      }
      if (isValidValue(fields()[3], other.Hashtags)) {
        this.Hashtags = data().deepCopy(fields()[3].schema(), other.Hashtags);
        fieldSetFlags()[3] = true;
      }
    }
    
    /** Creates a Builder by copying an existing Tweet instance */
    private Builder(Tweet other) {
            super(Tweet.SCHEMA$);
      if (isValidValue(fields()[0], other.tweetid)) {
        this.tweetid = data().deepCopy(fields()[0].schema(), other.tweetid);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.user)) {
        this.user = data().deepCopy(fields()[1].schema(), other.user);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.text)) {
        this.text = data().deepCopy(fields()[2].schema(), other.text);
        fieldSetFlags()[2] = true;
      }
      if (isValidValue(fields()[3], other.Hashtags)) {
        this.Hashtags = data().deepCopy(fields()[3].schema(), other.Hashtags);
        fieldSetFlags()[3] = true;
      }
    }

    /** Gets the value of the 'tweetid' field */
    public java.lang.Integer getTweetid() {
      return tweetid;
    }
    
    /** Sets the value of the 'tweetid' field */
    public Tweet.Builder setTweetid(int value) {
      validate(fields()[0], value);
      this.tweetid = value;
      fieldSetFlags()[0] = true;
      return this; 
    }
    
    /** Checks whether the 'tweetid' field has been set */
    public boolean hasTweetid() {
      return fieldSetFlags()[0];
    }
    
    /** Clears the value of the 'tweetid' field */
    public Tweet.Builder clearTweetid() {
      fieldSetFlags()[0] = false;
      return this;
    }

    /** Gets the value of the 'user' field */
    public java.lang.CharSequence getUser() {
      return user;
    }
    
    /** Sets the value of the 'user' field */
    public Tweet.Builder setUser(java.lang.CharSequence value) {
      validate(fields()[1], value);
      this.user = value;
      fieldSetFlags()[1] = true;
      return this; 
    }
    
    /** Checks whether the 'user' field has been set */
    public boolean hasUser() {
      return fieldSetFlags()[1];
    }
    
    /** Clears the value of the 'user' field */
    public Tweet.Builder clearUser() {
      user = null;
      fieldSetFlags()[1] = false;
      return this;
    }

    /** Gets the value of the 'text' field */
    public java.lang.CharSequence getText() {
      return text;
    }
    
    /** Sets the value of the 'text' field */
    public Tweet.Builder setText(java.lang.CharSequence value) {
      validate(fields()[2], value);
      this.text = value;
      fieldSetFlags()[2] = true;
      return this; 
    }
    
    /** Checks whether the 'text' field has been set */
    public boolean hasText() {
      return fieldSetFlags()[2];
    }
    
    /** Clears the value of the 'text' field */
    public Tweet.Builder clearText() {
      text = null;
      fieldSetFlags()[2] = false;
      return this;
    }

    /** Gets the value of the 'Hashtags' field */
    public java.util.List<java.lang.CharSequence> getHashtags() {
      return Hashtags;
    }
    
    /** Sets the value of the 'Hashtags' field */
    public Tweet.Builder setHashtags(java.util.List<java.lang.CharSequence> value) {
      validate(fields()[3], value);
      this.Hashtags = value;
      fieldSetFlags()[3] = true;
      return this; 
    }
    
    /** Checks whether the 'Hashtags' field has been set */
    public boolean hasHashtags() {
      return fieldSetFlags()[3];
    }
    
    /** Clears the value of the 'Hashtags' field */
    public Tweet.Builder clearHashtags() {
      Hashtags = null;
      fieldSetFlags()[3] = false;
      return this;
    }

    @Override
    public Tweet build() {
      try {
        Tweet record = new Tweet();
        record.tweetid = fieldSetFlags()[0] ? this.tweetid : (java.lang.Integer) defaultValue(fields()[0]);
        record.user = fieldSetFlags()[1] ? this.user : (java.lang.CharSequence) defaultValue(fields()[1]);
        record.text = fieldSetFlags()[2] ? this.text : (java.lang.CharSequence) defaultValue(fields()[2]);
        record.Hashtags = fieldSetFlags()[3] ? this.Hashtags : (java.util.List<java.lang.CharSequence>) defaultValue(fields()[3]);
        return record;
      } catch (Exception e) {
        throw new org.apache.avro.AvroRuntimeException(e);
      }
    }
  }
}
