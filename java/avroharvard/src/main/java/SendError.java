

@SuppressWarnings("all")
@org.apache.avro.specific.AvroGenerated
public class SendError extends org.apache.avro.specific.SpecificExceptionBase implements org.apache.avro.specific.SpecificRecord {
  public static final org.apache.avro.Schema SCHEMA$ = new org.apache.avro.Schema.Parser().parse("{\"type\":\"error\",\"name\":\"SendError\",\"fields\":[{\"name\":\"message\",\"type\":\"string\"}]}");
  public static org.apache.avro.Schema getClassSchema() { return SCHEMA$; }
  @Deprecated public java.lang.CharSequence message$;

  public SendError() {
    super();
  }
  
  public SendError(Object value) {
    super(value);
  }

  public SendError(Throwable cause) {
    super(cause);
  }

  public SendError(Object value, Throwable cause) {
    super(value, cause);
  }
  
  public org.apache.avro.Schema getSchema() { return SCHEMA$; }
  // Used by DatumWriter.  Applications should not call. 
  public java.lang.Object get(int field$) {
    switch (field$) {
    case 0: return message$;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }
  // Used by DatumReader.  Applications should not call. 
  @SuppressWarnings(value="unchecked")
  public void put(int field$, java.lang.Object value$) {
    switch (field$) {
    case 0: message$ = (java.lang.CharSequence)value$; break;
    default: throw new org.apache.avro.AvroRuntimeException("Bad index");
    }
  }

  /**
   * Gets the value of the 'message$' field.
   */
  public java.lang.CharSequence getMessage$() {
    return message$;
  }

  /**
   * Sets the value of the 'message$' field.
   * @param value the value to set.
   */
  public void setMessage$(java.lang.CharSequence value) {
    this.message$ = value;
  }

  /** Creates a new SendError RecordBuilder */
  public static SendError.Builder newBuilder() {
    return new SendError.Builder();
  }
  
  /** Creates a new SendError RecordBuilder by copying an existing Builder */
  public static SendError.Builder newBuilder(SendError.Builder other) {
    return new SendError.Builder(other);
  }
  
  /** Creates a new SendError RecordBuilder by copying an existing SendError instance */
  public static SendError.Builder newBuilder(SendError other) {
    return new SendError.Builder(other);
  }
  
  /**
   * RecordBuilder for SendError instances.
   */
  public static class Builder extends org.apache.avro.specific.SpecificErrorBuilderBase<SendError>
    implements org.apache.avro.data.ErrorBuilder<SendError> {

    private java.lang.CharSequence message$;

    /** Creates a new Builder */
    private Builder() {
      super(SendError.SCHEMA$);
    }
    
    /** Creates a Builder by copying an existing Builder */
    private Builder(SendError.Builder other) {
      super(other);
      if (isValidValue(fields()[0], other.message$)) {
        this.message$ = data().deepCopy(fields()[0].schema(), other.message$);
        fieldSetFlags()[0] = true;
      }
    }
    
    /** Creates a Builder by copying an existing SendError instance */
    private Builder(SendError other) {
      super(other);
      if (isValidValue(fields()[0], other.message$)) {
        this.message$ = data().deepCopy(fields()[0].schema(), other.message$);
        fieldSetFlags()[0] = true;
      }
    }

    @Override
    public SendError.Builder setValue(Object value) {
      super.setValue(value);
      return this;
    }
    
    @Override
    public SendError.Builder clearValue() {
      super.clearValue();
      return this;
    }

    @Override
    public SendError.Builder setCause(Throwable cause) {
      super.setCause(cause);
      return this;
    }
    
    @Override
    public SendError.Builder clearCause() {
      super.clearCause();
      return this;
    }

    /** Gets the value of the 'message$' field */
    public java.lang.CharSequence getMessage$() {
      return message$;
    }
    
    /** Sets the value of the 'message$' field */
    public SendError.Builder setMessage$(java.lang.CharSequence value) {
      validate(fields()[0], value);
      this.message$ = value;
      fieldSetFlags()[0] = true;
      return this; 
    }
    
    /** Checks whether the 'message$' field has been set */
    public boolean hasMessage$() {
      return fieldSetFlags()[0];
    }
    
    /** Clears the value of the 'message$' field */
    public SendError.Builder clearMessage$() {
      message$ = null;
      fieldSetFlags()[0] = false;
      return this;
    }

    @Override
    public SendError build() {
      try {
        SendError record = new SendError(getValue(), getCause());
        record.message$ = fieldSetFlags()[0] ? this.message$ : (java.lang.CharSequence) defaultValue(fields()[0]);
        return record;
      } catch (Exception e) {
        throw new org.apache.avro.AvroRuntimeException(e);
      }
    }
  }
}