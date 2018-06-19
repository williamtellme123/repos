
@SuppressWarnings("all")
@org.apache.avro.specific.AvroGenerated
public class TweetRecord extends org.apache.avro.specific.SpecificRecordBase implements org.apache.avro.specific.SpecificRecord {
  public static final org.apache.avro.Schema SCHEMA$ = new org.apache.avro.Schema.Parser().parse("{\"type\":\"record\",\"name\":\"TweetRecord\",\"fields\":[{\"name\":\"tweetId\",\"type\":\"int\"},{\"name\":\"text\",\"type\":\"string\"},{\"name\":\"username\",\"type\":\"string\"}]}");
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }
  @Deprecated public int tweetId;
  @Deprecated public java.lang.CharSequence text;
  @Deprecated public java.lang.CharSequence username;

  /**
   * Default constructor.  Note that this does not initialize fields
   * to their default values from the schema.  If that is desired then
   * one should use <code>newBuilder()</code>. 
   */
  public TweetRecord() {}

  /**
   * All-args constructor.
   */
  public TweetRecord(java.lang.Integer tweetId, java.lang.CharSequence text, java.lang.CharSequence username) {
    this.tweetId = tweetId;
    this.text = text;
    this.username = username;
  }

  public org.apache.avro.Schema getSchema() { return SCHEMA$; }
  // Used by DatumWriter.  Applications should not call. 
  public java.lang.Object get(int field$) {
    switch (field$) {
    case 0: return tweetId;
    case 1: return text;
    case 2: return username;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }
  // Used by DatumReader.  Applications should not call. 
  @SuppressWarnings(value="unchecked")
  public void put(int field$, java.lang.Object value$) {
    switch (field$) {
    case 0: tweetId = (java.lang.Integer)value$; break;
    case 1: text = (java.lang.CharSequence)value$; break;
    case 2: username = (java.lang.CharSequence)value$; break;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }

  /**
   * Gets the value of the 'tweetId' field.
   */
  public java.lang.Integer getTweetId() {
    return tweetId;
  }

  /**
   * Sets the value of the 'tweetId' field.
   * @param value the value to set.
   */
  public void setTweetId(java.lang.Integer value) {
    this.tweetId = value;
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
   * Gets the value of the 'username' field.
   */
  public java.lang.CharSequence getUsername() {
    return username;
  }

  /**
   * Sets the value of the 'username' field.
   * @param value the value to set.
   */
  public void setUsername(java.lang.CharSequence value) {
    this.username = value;
  }

  /** Creates a new TweetRecord RecordBuilder */
  public static TweetRecord.Builder newBuilder() {
    return new TweetRecord.Builder();
  }
  
  /** Creates a new TweetRecord RecordBuilder by copying an existing Builder */
  public static TweetRecord.Builder newBuilder(TweetRecord.Builder other) {
    return new TweetRecord.Builder(other);
  }
  
  /** Creates a new TweetRecord RecordBuilder by copying an existing TweetRecord instance */
  public static TweetRecord.Builder newBuilder(TweetRecord other) {
    return new TweetRecord.Builder(other);
  }
  
  /**
   * RecordBuilder for TweetRecord instances.
   */
  public static class Builder extends org.apache.avro.specific.SpecificRecordBuilderBase<TweetRecord>
    implements org.apache.avro.data.RecordBuilder<TweetRecord> {

    private int tweetId;
    private java.lang.CharSequence text;
    private java.lang.CharSequence username;

    /** Creates a new Builder */
    private Builder() {
      super(TweetRecord.SCHEMA$);
    }
    
    /** Creates a Builder by copying an existing Builder */
    private Builder(TweetRecord.Builder other) {
      super(other);
      if (isValidValue(fields()[0], other.tweetId)) {
        this.tweetId = data().deepCopy(fields()[0].schema(), other.tweetId);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.text)) {
        this.text = data().deepCopy(fields()[1].schema(), other.text);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.username)) {
        this.username = data().deepCopy(fields()[2].schema(), other.username);
        fieldSetFlags()[2] = true;
      }
    }
    
    /** Creates a Builder by copying an existing TweetRecord instance */
    private Builder(TweetRecord other) {
            super(TweetRecord.SCHEMA$);
      if (isValidValue(fields()[0], other.tweetId)) {
        this.tweetId = data().deepCopy(fields()[0].schema(), other.tweetId);
        fieldSetFlags()[0] = true;
      }
      if (isValidValue(fields()[1], other.text)) {
        this.text = data().deepCopy(fields()[1].schema(), other.text);
        fieldSetFlags()[1] = true;
      }
      if (isValidValue(fields()[2], other.username)) {
        this.username = data().deepCopy(fields()[2].schema(), other.username);
        fieldSetFlags()[2] = true;
      }
    }

    /** Gets the value of the 'tweetId' field */
    public java.lang.Integer getTweetId() {
      return tweetId;
    }
    
    /** Sets the value of the 'tweetId' field */
    public TweetRecord.Builder setTweetId(int value) {
      validate(fields()[0], value);
      this.tweetId = value;
      fieldSetFlags()[0] = true;
      return this; 
    }
    
    /** Checks whether the 'tweetId' field has been set */
    public boolean hasTweetId() {
      return fieldSetFlags()[0];
    }
    
    /** Clears the value of the 'tweetId' field */
    public TweetRecord.Builder clearTweetId() {
      fieldSetFlags()[0] = false;
      return this;
    }

    /** Gets the value of the 'text' field */
    public java.lang.CharSequence getText() {
      return text;
    }
    
    /** Sets the value of the 'text' field */
    public TweetRecord.Builder setText(java.lang.CharSequence value) {
      validate(fields()[1], value);
      this.text = value;
      fieldSetFlags()[1] = true;
      return this; 
    }
    
    /** Checks whether the 'text' field has been set */
    public boolean hasText() {
      return fieldSetFlags()[1];
    }
    
    /** Clears the value of the 'text' field */
    public TweetRecord.Builder clearText() {
      text = null;
      fieldSetFlags()[1] = false;
      return this;
    }

    /** Gets the value of the 'username' field */
    public java.lang.CharSequence getUsername() {
      return username;
    }
    
    /** Sets the value of the 'username' field */
    public TweetRecord.Builder setUsername(java.lang.CharSequence value) {
      validate(fields()[2], value);
      this.username = value;
      fieldSetFlags()[2] = true;
      return this; 
    }
    
    /** Checks whether the 'username' field has been set */
    public boolean hasUsername() {
      return fieldSetFlags()[2];
    }
    
    /** Clears the value of the 'username' field */
    public TweetRecord.Builder clearUsername() {
      username = null;
      fieldSetFlags()[2] = false;
      return this;
    }

    @Override
    public TweetRecord build() {
      try {
        TweetRecord record = new TweetRecord();
        record.tweetId = fieldSetFlags()[0] ? this.tweetId : (java.lang.Integer) defaultValue(fields()[0]);
        record.text = fieldSetFlags()[1] ? this.text : (java.lang.CharSequence) defaultValue(fields()[1]);
        record.username = fieldSetFlags()[2] ? this.username : (java.lang.CharSequence) defaultValue(fields()[2]);
        return record;
      } catch (Exception e) {
        throw new org.apache.avro.AvroRuntimeException(e);
      }
    }
  }
}
