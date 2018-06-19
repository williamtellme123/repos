package com.dcn.teamcity.awsS3Plugin;

/**
 * Created by sg0216948 on 7/16/16.
 *
 * @author <a href="mailto:gonzalo.docarmo@gmail.com">Gonzalo G. do Carmo Norte</a>
 */
public class AgentRunnerBuildParametersModel {

    private final String bucketName;
    private final String publicKey;
    private final String privateKey;
    private final boolean emptyBucketBeforeUpload;
    private final String artifactsPath;
    private final String httpHeaderCacheControl;
    private final String httpProxy;

    public AgentRunnerBuildParametersModel(String bucketName, String publicKey, String privateKey, boolean emptyBucketBeforeUpload, String artifactsPath, String httpHeaderCacheControl, String httpProxy) {
        this.bucketName = bucketName;
        this.publicKey = publicKey;
        this.privateKey = privateKey;
        this.emptyBucketBeforeUpload = emptyBucketBeforeUpload;
        this.artifactsPath = artifactsPath;
        this.httpHeaderCacheControl = httpHeaderCacheControl;
        this.httpProxy = httpProxy;
    }

    public String getBucketName() {
        return bucketName;
    }

    public String getPublicKey() {
        return publicKey;
    }

    public String getPrivateKey() {
        return privateKey;
    }

    public boolean isEmptyBucketBeforeUpload() {
        return emptyBucketBeforeUpload;
    }

    public String getArtifactsPath() {
        return artifactsPath;
    }

    public String getHttpHeaderCacheControl() {
        return httpHeaderCacheControl;
    }

    public String getHttpProxy() {
        return httpProxy;
    }

    @Override
    public int hashCode() {
        int a = this.getBucketName().length();
        int b = this.getPublicKey().length();
        int c = this.getPublicKey().length() + this.getPrivateKey().length() / 2;
        return Long.valueOf((a * 31 + b) * 31 + c).hashCode();
    }

    @Override
    public String toString() {
        return String.format("Bucket: %s - Public Key: %s",
                getBucketName(),
                getPublicKey().substring(0, getPublicKey().length() / 2));
    }

    @Override
    public boolean equals(Object obj) {
        if (obj != null && obj instanceof AgentRunnerBuildParametersModel) {
            AgentRunnerBuildParametersModel other = (AgentRunnerBuildParametersModel) obj;
            return this.getBucketName().equals(other.getBucketName()) &&
                    this.getPublicKey().equals(other.getPublicKey()) &&
                    this.getPrivateKey().equals(other.getPrivateKey()) &&
                    this.isEmptyBucketBeforeUpload() == other.isEmptyBucketBeforeUpload() &&
                    this.getHttpProxy().equals(other.getHttpProxy()) &&
                    this.getHttpHeaderCacheControl().equals(other.getHttpHeaderCacheControl());
        } else {
            return false;
        }
    }
}
