node{
   stage('SCM Checkout'){
     git 'https://github.com/rajeshgitlab/my-app'
   }
   stage('maven-buildstage'){

      def mvnHome =  tool name: 'maven3', type: 'maven'   
      sh "${mvnHome}/bin/mvn clean package"
	  sh 'mv target/myweb*.war target/newapp.war'
   }
    stage('Build Docker Image'){
   sh 'docker build -t myimage2/app:0.0.5 .'
   }
   stage('Docker Image Push'){
   withCredentials([string(credentialsId: 'dockerPass', variable: 'dockerPassword')]) {
   sh "docker login -u rajesh2023 -p ${dockerPassword}"
    }
     sh 'docker tag myimage2/app:0.0.5  rajesh2023/project'
     sh 'docker push rajesh2023/project'
   }
   stage('Nexus Image Push'){
   sh 'docker login -u admin -p nexus@123 52.66.125.144:8085'
   sh 'docker tag myimage2/app:0.0.5   52.66.125.144:8085/rajesh:1.0'
   sh 'docker push  52.66.125.144:8085/rajesh:1.0'
   }
     stage('Remove Previous Container'){
	try{
		sh 'docker rm -f tomcattest'
	}catch(error){
		//  do nothing if there is an exception
	}
     stage('Docker deployment'){
   sh 'docker run -d -p 7010:8080 
   }
  }
}
